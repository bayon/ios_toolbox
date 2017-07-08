
#import "RightPanelViewController.h"

#import "Animal.h"

@interface RightPanelViewController ()

@property (nonatomic, weak) IBOutlet UITableView *myTableView;
@property (nonatomic, weak) IBOutlet UITableViewCell *cellMain;

@property (nonatomic, strong) NSMutableArray *arrayOfAnimals;

@end

@implementation RightPanelViewController

#pragma mark -
#pragma mark View Did Load/Unload

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupAnimalsArray];
}

#pragma mark -
#pragma mark Array Setup

- (void)setupAnimalsArray
{
    NSArray *animals = @[
    [Animal itemWithTitle:@"White Dog Portrait" withImage:[UIImage imageNamed:@"ID-10034505.jpg"] withCreator:@"photostock"],
    [Animal itemWithTitle:@"Black Labrador Retriever" withImage:[UIImage imageNamed:@"ID-1009881.jpg"] withCreator:@"Michal Marcol"],
    [Animal itemWithTitle:@"Anxious Dog" withImage:[UIImage imageNamed:@"ID-100120.jpg"] withCreator:@"James Barker"],
    [Animal itemWithTitle:@"Intelligent Dog" withImage:[UIImage imageNamed:@"ID-100137.jpg"] withCreator:@"James Barker"]
    ];
    
    self.arrayOfAnimals = [NSMutableArray arrayWithArray:animals];
    
    [self.myTableView reloadData];
}

#pragma mark -
#pragma mark UITableView Datasource/Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arrayOfAnimals count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellMainNibID = @"cellMain";
    
    _cellMain = [tableView dequeueReusableCellWithIdentifier:cellMainNibID];
    if (_cellMain == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"MainCellRight" owner:self options:nil];
    }
    
    UIImageView *mainImage = (UIImageView *)[_cellMain viewWithTag:1];
    
    UILabel *imageTitle = (UILabel *)[_cellMain viewWithTag:2];
    UILabel *creator = (UILabel *)[_cellMain viewWithTag:3];
    
    if ([_arrayOfAnimals count] > 0)
    {
        Animal *currentRecord = [self.arrayOfAnimals objectAtIndex:indexPath.row];
        
        mainImage.image = currentRecord.image;
        imageTitle.text = [NSString stringWithFormat:@"%@", currentRecord.title];
        creator.text = [NSString stringWithFormat:@"%@", currentRecord.creator];
    }
    
    return _cellMain;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Animal *currentRecord = [self.arrayOfAnimals objectAtIndex:indexPath.row];
    [_delegate animalSelected:currentRecord];
}

#pragma mark -
#pragma mark Default System Code

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
