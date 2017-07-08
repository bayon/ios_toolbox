#import "TableViewController.h"
#import "AppDelegateProtocol.h"
#import "AppMemory.h"
#import "tabbartestAppDelegate.h"
@implementation TableViewController
@synthesize selectedCellItem;
@synthesize mutableData,urlConnection,mutableArray;

-(AppMemory*)theAppDataObject;
{
    id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
    AppMemory *theDataObject ;
    theDataObject = (AppMemory*)theDelegate.theAppDataObject;
    return theDataObject;
    
}
 

- (void)viewDidLoad {
    NSLog(@"\n \n  \n FILE->FUNCTION: %s",__FUNCTION__);
	self.navigationItem.title = @"Selected Item";
	CGRect frame = CGRectMake(0, 0, 320, 180);
	self.view = [[UIView alloc] initWithFrame:frame];
	self.view.backgroundColor = [UIColor whiteColor];
		frame = CGRectMake(30, 20, 300, 50);
	UILabel *label = [[UILabel alloc] initWithFrame:frame];
	label.text = selectedCellItem;
	[self.view addSubview:label];
	[label release];
    [super viewDidLoad];
    
    
    
    AppMemory *theDataObject =[self theAppDataObject]; 
    
    // GET SUBSTRING
    //FIND THE PERIOD
    NSString *string1 =theDataObject.mem_text1;
    NSRange match;
    match = [string1 rangeOfString: @"."];
    int locationOfSeparator = match.location;
    // SUBTRACT THE FILENAME
    NSMutableString *stringA = [NSMutableString stringWithString: string1];
    NSString *string2;
    string2 = [stringA substringWithRange: NSMakeRange (0, locationOfSeparator)];
    //NSLog (@"filename without extension: %@", string2);
    
    theDataObject.mem_text2 = [[NSString alloc] init];
    theDataObject.mem_text2 =string2;
    NSLog (@"filename without extension: %@", theDataObject.mem_text2);
    
    [self requestImageDownload];
   
	
}

//requestImageDownload
-(void)requestImageDownload{
    AppMemory *theDataObject =[self theAppDataObject]; 
    
    
    NSLog(@"\n GET THIS IMAGE \n  %@",theDataObject.mem_text1);
    //method=get_Images will return a list of available images in the database.
    //NSString *myRequestString = @"method=download_Image&image_filename=UCS_DownloadScreen.jpg";
    NSString *myRequestString = [NSString stringWithFormat:@"method=download_Image&image_filename=%@",theDataObject.mem_text1];
    NSData *jsonData = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
    NSString *url = @"http://www.forteworks.com/jsonImages.php";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLCacheStorageAllowed timeoutInterval:30.0];
    //POST data 
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: jsonData];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    
    self.mutableData = [NSMutableData data]; 
    self.urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}
 
//NSURLConnection: appending data =============================================================== 
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    //NSLog(@"\n didReceiveResponse");
    [self.mutableData setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {  
    // NSLog(@"\n didReceiveData:");
    [self.mutableData appendData:data]; 
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {    
    NSLog(@"\n didFailWithError");
    //NSLog([NSString stringWithFormat:@"Connection failed: %@", [error description]]);
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSLog(@"connectionDidFinishLoading"); 
   
    [self handleImageDownload];
    
}
//handleImageDownload
-(void)handleImageDownload{
    /* HANDLE IMAGE DOWNLOAD */
    AppMemory *theDataObject =[self theAppDataObject]; 
    UIImage *imageDownloaded = [UIImage imageWithData:self.mutableData];
    //get documentsDirectory path
    NSString *documentsDirectory = [self getDocumentDirectory];
    NSString *imageName = [[NSString alloc]initWithFormat:theDataObject.mem_text2];
    NSString *imageExtension = [[NSString alloc]initWithFormat:@"jpg"];
    float imageWidth = 200.25;
    float imageHeight = 100.25;
    //Save the downloaded image ....
    [self saveImageToDocuments:imageDownloaded withFileName:imageName ofType:imageExtension inDirectory:documentsDirectory];
    //Load Image From App Documents
    [self loadImageFromDocuments:imageName ofType:imageExtension width:imageWidth height:imageHeight];
    
    
}

//getDocumentDirectory
-(NSString *)getDocumentDirectory{
    //return a NSString of document directory path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}
//saveImageToDocuments 
-(void) saveImageToDocuments:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
    if ([[extension lowercaseString] isEqualToString:@"png"]) {
        [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
    } else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"]) {
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSAtomicWrite error:nil];
    } else {
        NSLog(@"Image Save Failed\nExtension: (%@) is not recognized, use (PNG/JPG)", extension);
    }
}
//Load Image From App Documents
-(void) loadImageFromDocuments:(NSString *)imageName ofType:(NSString*)extension width:(float)width height:(float)height{
    
    //get documentsDirectory path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName,extension]];
    UIImageView *  myImageView =[[UIImageView alloc] initWithFrame:CGRectMake(30,100,width,height)];
    UIImage *myNewImage = [UIImage imageWithContentsOfFile:fullPath];
    myImageView.image= myNewImage;
    [self.view addSubview: myImageView];
    [self.view bringSubviewToFront:myImageView];
    
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {  [super didReceiveMemoryWarning]; }

- (void)viewDidUnload { [super viewDidUnload]; }


- (void)dealloc {  [super dealloc]; }


@end
