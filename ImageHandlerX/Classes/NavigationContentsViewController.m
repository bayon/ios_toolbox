#import "NavigationContentsViewController.h"
#import "TableViewController.h"
#import "AppDelegateProtocol.h"
#import "AppMemory.h"
#import "tabbartestAppDelegate.h"

@implementation NavigationContentsViewController

@synthesize imagesArray;
@synthesize imageTableView;
@synthesize downloadData,urlConnection,mutableArray;

-(AppMemory*)theAppDataObject;
{
    id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
    AppMemory *theDataObject ;
    theDataObject = (AppMemory*)theDelegate.theAppDataObject;
    return theDataObject;
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)loadView{
    imagesArray = [[NSMutableArray alloc] init];
    [self sendRequestForJSONReturnData];
    [self setUpTable];
}
-(void)viewDidLoad{
}
-(void)setUpTable{
    imageTableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStylePlain];
	imageTableView.delegate = self;
	imageTableView.dataSource = self;
	imageTableView.autoresizesSubviews = YES;
	 
    AppMemory *theDataObject =[self theAppDataObject]; 
    for(NSString * myStr in theDataObject.mutableArray) {
        [imagesArray addObject:myStr];
    }
	self.navigationItem.title = @"List of Images";
	self.view = imageTableView;
}
/**
 method=get_Images will return a list of available images in the database.
 */
-(void)sendRequestForJSONReturnData{
    NSString *myRequestString = @"method=get_Images";
    NSData *jsonData = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
    NSString *url = @"http://www.forteworks.com/jsonImages.php";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLCacheStorageAllowed timeoutInterval:30.0];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: jsonData];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    self.downloadData = [NSMutableData data]; 
    self.urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

-(NSDictionary*)jsonToDictionary:(NSMutableData*)mutableData{
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:mutableData options:NSJSONReadingMutableLeaves error:&myError];
    return res;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.downloadData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {  
    [self.downloadData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {    
    NSLog(@"\n didFailWithError");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self handleSuccessfulDownload];
}

-(void) checkData{
    AppMemory *theDataObject =[self theAppDataObject];
    for(NSString * myStr in theDataObject.mutableArray) {
        NSLog(@"\n %@",myStr);
    }
}

-(void)handleSuccessfulDownload{
    NSDictionary *results = [self jsonToDictionary:self.downloadData];
    [self sortThroughDictionary:results];
}

-(void)sortThroughDictionary:(NSDictionary *)dictionary{
    AppMemory *theDataObject =[self theAppDataObject]; 
    theDataObject.mutableArray = [[NSMutableArray alloc] init];
   
    for(id key in dictionary) {
        id value = [dictionary objectForKey:key];
        BOOL valueIsArray = [value isKindOfClass:[NSArray class]];
        if(valueIsArray){
            for (id object in value) {
                BOOL objectIsArray = [object isKindOfClass:[NSArray class]];
                if(objectIsArray){
                    for (id element in object) {
                        BOOL elementIsArray = [element isKindOfClass:[NSArray class]];
                        if(elementIsArray){
                                //
                        }else{
                                [imagesArray addObject:[element objectForKey:@"image_filename"]];
                                [theDataObject.mutableArray addObject:[element objectForKey:@"image_filename"]];
                         }
                    }//end for
                }else{
                }//end if
            }//end for 
        }else{
        }//end if
    }//end for
    
    [imageTableView reloadData];
}

-(void)handleImageDownloadRequest{
    UIImage *imageDownloaded = [UIImage imageWithData:self.downloadData];
    NSString *documentsDirectory = [self getDocumentDirectory];
    NSString *imageName = [[NSString alloc]initWithFormat:@"UCS_DownloadScreen"];
    NSString *imageExtension = [[NSString alloc]initWithFormat:@"jpg"];
    //float imageWidth = 200.25;
    //float imageHeight = 100.25;
    [self saveImageToDocuments:imageDownloaded withFileName:imageName ofType:imageExtension inDirectory:documentsDirectory];
}

-(void)requestImageDownload:(NSString *)parameter{
    NSString *method = @"method=download_Image&";
    NSString *myRequestString  ;
     myRequestString = [NSString stringWithFormat:@"%@%@", method , parameter];
    NSData *jsonData = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
    NSString *url = @"http://www.forteworks.com/jsonImages.php";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLCacheStorageAllowed timeoutInterval:30.0];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: jsonData];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    self.downloadData = [NSMutableData data]; 
    self.urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

-(NSString *)getDocumentDirectory{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

-(void) saveImageToDocuments:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
    if ([[extension lowercaseString] isEqualToString:@"png"]) {
        [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
    } else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"]) {
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSAtomicWrite error:nil];
    } else {
        NSLog(@"Image Save Failed\nExtension: (%@) is not recognized, use (PNG/JPG)", extension);
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [imagesArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 	static NSString *CellIdentifier = @"Cell";
 	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
  	NSString *cellValue = [imagesArray objectAtIndex:indexPath.row];
	cell.textLabel.text = cellValue;
 	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AppMemory *theDataObject =[self theAppDataObject]; 
    theDataObject.mem_text1 = [[NSString alloc] init];
    theDataObject.mem_text1 =[imagesArray objectAtIndex:indexPath.row];
    NSString *selectedCellItem = [imagesArray objectAtIndex:indexPath.row];
	TableViewController *fvController = [[TableViewController alloc] initWithNibName:@"TableViewController" bundle:[NSBundle mainBundle]];
	fvController.selectedCellItem = selectedCellItem;
	[self.navigationController pushViewController:fvController animated:YES];
	[fvController release];
	fvController = nil;
}

- (void)didReceiveMemoryWarning { [super didReceiveMemoryWarning]; }

- (void)viewDidUnload { [super viewDidUnload]; }

- (void)dealloc { [imagesArray release]; [super dealloc]; }

@end
 