
#import "CenterViewController.h"
#import "Animal.h"

@interface CenterViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *mainImageView;
@property (nonatomic, weak) IBOutlet UILabel *imageTitle;
@property (nonatomic, weak) IBOutlet UILabel *imageCreator;
@property (nonatomic, strong) NSMutableArray *imagesArray;

@end

@implementation CenterViewController

- (void)viewDidLoad {
	[super viewDidLoad];
}

#pragma mark -
#pragma mark Button Actions

- (IBAction)btnMovePanelRight:(id)sender {
	UIButton *button = sender;
	switch (button.tag) {
		case 0: {
			[_delegate movePanelToOriginalPosition];
			break;
		}
		case 1: {
			[_delegate movePanelRight];
			break;
		}
		default:
			break;
	}
}

#pragma mark -
#pragma mark Delagate Method for capturing selected image

- (void)imageSelected:(UIImage *)image withTitle:(NSString *)imageTitle withCreator:(NSString *)imageCreator {
	if (image) {
		self.mainImageView.image = image;
		self.imageTitle.text = [NSString stringWithFormat:@"%@", imageTitle];
		self.imageCreator.text = [NSString stringWithFormat:@"%@", imageCreator];
	}
}

- (void)animalSelected:(Animal *)animal {
	if (animal) {
		[self showAnimalSelected:animal];
	}
}

- (void)showAnimalSelected:(Animal *)animalSelected {
	self.mainImageView.image = animalSelected.image;
	self.imageTitle.text = [NSString stringWithFormat:@"%@", animalSelected.title];
	self.imageCreator.text = [NSString stringWithFormat:@"%@", animalSelected.creator];
}

#pragma mark -
#pragma mark Default System Code

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
	}
	return self;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

@end
