
#import "LeftPanelViewController.h"

#import "Animal.h"

@interface LeftPanelViewController ()

@property (nonatomic, weak) IBOutlet UITableView *myTableView;
@property (nonatomic, weak) IBOutlet UITableViewCell *cellMain;
@property (nonatomic, strong) NSMutableArray *arrayOfAnimals;

@end

@implementation LeftPanelViewController
#pragma mark -
#pragma mark Default System Code

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
	}
	return self;
}
- (void)viewDidLoad {
	[super viewDidLoad];
	[self setupAnimalsArray];
}
- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Array Setup

- (void)setupAnimalsArray {
	NSArray *animals = @[
	        [Animal itemWithTitle:@"Sleeping Cat" withImage:[UIImage imageNamed:@"ID-100113060.jpg"] withCreator:@"papaija2008"],
	        [Animal itemWithTitle:@"Pussy Cat" withImage:[UIImage imageNamed:@"ID-10022760.jpg"] withCreator:@"Carlos Porto"],
	        [Animal itemWithTitle:@"Korat Domestic Cat" withImage:[UIImage imageNamed:@"ID-10091065.jpg"] withCreator:@"sippakorn"],
	        [Animal itemWithTitle:@"Tabby Cat" withImage:[UIImage imageNamed:@"ID-10047796.jpg"] withCreator:@"dan"],
	        [Animal itemWithTitle:@"Yawning Cat" withImage:[UIImage imageNamed:@"ID-10092572.jpg"] withCreator:@"dan"],
	        [Animal itemWithTitle:@"Tabby Cat" withImage:[UIImage imageNamed:@"ID-10041194.jpg"] withCreator:@"dan"],
	        [Animal itemWithTitle:@"Cat On The Rocks" withImage:[UIImage imageNamed:@"ID-10017782.jpg"] withCreator:@"Willem Siers"],
	        [Animal itemWithTitle:@"Brown Cat Standing" withImage:[UIImage imageNamed:@"ID-10091745.jpg"] withCreator:@"aopsan"],
	        [Animal itemWithTitle:@"Burmese Cat" withImage:[UIImage imageNamed:@"ID-10056941.jpg"] withCreator:@"Rosemary Ratcliff"],
	        [Animal itemWithTitle:@"Cat" withImage:[UIImage imageNamed:@"ID-10019208.jpg"] withCreator:@"dan"],
	        [Animal itemWithTitle:@"Cat" withImage:[UIImage imageNamed:@"ID-10011404.jpg"] withCreator:@"graur codrin"]
	    ];

	self.arrayOfAnimals = [NSMutableArray arrayWithArray:animals];

	[self.myTableView reloadData];
}

#pragma mark -
#pragma mark UITableView Datasource/Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [_arrayOfAnimals count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 54;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellMainNibID = @"cellMain";

	_cellMain = [tableView dequeueReusableCellWithIdentifier:cellMainNibID];
	if (_cellMain == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"MainCellLeft" owner:self options:nil];
	}

	UIImageView *mainImage = (UIImageView *)[_cellMain viewWithTag:1];

	UILabel *imageTitle = (UILabel *)[_cellMain viewWithTag:2];
	UILabel *creator = (UILabel *)[_cellMain viewWithTag:3];

	if ([_arrayOfAnimals count] > 0) {
		Animal *currentRecord = [self.arrayOfAnimals objectAtIndex:indexPath.row];
		mainImage.image = currentRecord.image;
		imageTitle.text = [NSString stringWithFormat:@"%@", currentRecord.title];
		creator.text = [NSString stringWithFormat:@"%@", currentRecord.creator];
	}
	return _cellMain;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	Animal *currentRecord = [self.arrayOfAnimals objectAtIndex:indexPath.row];
	[_delegate animalSelected:currentRecord];
}

@end
