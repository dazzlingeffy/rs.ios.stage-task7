//
//  AuthViewController.m
//  AuthScreen
//
//  Created by ira on 04.07.2021.
//

#import "AuthViewController.h"
#import "UIButtonBackgroundColor.h"

@interface AuthViewController ()

@property (strong, nonatomic) IBOutlet UITextField *loginField;
@property (strong, nonatomic) IBOutlet UITextField *passField;
@property (strong, nonatomic) IBOutlet UIButton *authBtn;

@end

@implementation AuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // RSSchool header
    CGFloat headerMargin = self.view.safeAreaInsets.top + 80;
    UILabel *header = [[UILabel alloc] initWithFrame:CGRectMake(0, headerMargin, 158, 50)];
    header.text = @"RSSchool";
    header.font = [UIFont boldSystemFontOfSize:36];
    [header setCenter: CGPointMake(self.view.center.x, header.center.y)];
    
    self.view.backgroundColor = [UIColor colorNamed:@"white"];

    [self.view addSubview: header];
    
    // login textfield
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 72;
    CGFloat loginMargin = headerMargin + 50 + 80;

    _loginField = [[UITextField alloc] initWithFrame: CGRectMake(0, loginMargin, width, 50)];
    _loginField.placeholder = @"Login";
    _loginField.borderStyle = UITextBorderStyleRoundedRect;
    _loginField.autocorrectionType = UITextAutocorrectionTypeNo;
    _loginField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    _loginField.layer.borderColor = [[UIColor colorNamed: @"blackCoral"] CGColor];
    _loginField.layer.borderWidth = 1.5;
    _loginField.layer.cornerRadius = 5;
    
    [_loginField setCenter: CGPointMake(self.view.center.x, _loginField.center.y)];
    
    [self.view addSubview: _loginField];
    
    // password textfield
    
    CGFloat passMargin = loginMargin + 50 + 30;

    _passField = [[UITextField alloc] initWithFrame: CGRectMake(0, passMargin, width, 50)];
    _passField.placeholder = @"Password";
    _passField.borderStyle = UITextBorderStyleRoundedRect;
    _passField.autocorrectionType = UITextAutocorrectionTypeNo;
    _passField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _passField.secureTextEntry = YES;
    
    _passField.layer.borderColor = [[UIColor colorNamed: @"blackCoral"] CGColor];
    _passField.layer.borderWidth = 1.5;
    _passField.layer.cornerRadius = 5;
    
    [_passField setCenter: CGPointMake(self.view.center.x, _passField.center.y)];
    
    [self.view addSubview: _passField];
    
    //auth button
    
    CGFloat btnMargin = passMargin + 50 + 60;
    
    _authBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _authBtn.frame = CGRectMake(0, btnMargin, 156, 42);
    _authBtn.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
    [_authBtn setTitle:@"Authorize" forState:UIControlStateNormal];
    [_authBtn setTitleColor: [UIColor colorNamed: @"littleBoyBlue"] forState:UIControlStateNormal];
    [_authBtn setBackgroundColor:[UIColor colorNamed:@"white"]];
    
    _authBtn.layer.borderColor = [[UIColor colorNamed: @"littleBoyBlue"] CGColor];
    _authBtn.layer.borderWidth = 2;
    _authBtn.layer.cornerRadius = 5;
    
    // add image to btn
    
//    UIImage *img = [UIImage imageNamed:@"person"];
//    UIImageView *imgView = [[UIImageView alloc] initWithImage: img];
    [_authBtn setImage:[UIImage imageNamed:@"person"] forState:UIControlStateNormal];
    [_authBtn setImage:[UIImage imageNamed:@"personFill"] forState:UIControlStateHighlighted];
    _authBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_authBtn setImageEdgeInsets: UIEdgeInsetsMake(10, 15, 10, 25)];
    [_authBtn setBackgroundColor:[[UIColor colorNamed:@"littleBoyBlue"] colorWithAlphaComponent:0.2] forState:UIControlStateHighlighted];
    [_authBtn setTitleColor: [[UIColor colorNamed: @"littleBoyBlue"] colorWithAlphaComponent:0.4] forState:UIControlStateHighlighted];
    
    [_authBtn setCenter: CGPointMake(self.view.center.x, _authBtn.center.y)];
    
    [self.view addSubview: _authBtn];
    
    // auth button action
    
    [_authBtn addTarget:self action:@selector(authBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)authBtnTapped:(UIButton *)sender {
    NSString *login = self.loginField.text;
    NSString *pass = self.passField.text;
    
    if (![login  isEqual: @"username"]) {
        self.loginField.layer.borderColor = [[UIColor colorNamed: @"venetianRed"] CGColor];
    }
    if (![pass isEqual: @"password"]) {
        self.passField.layer.borderColor = [[UIColor colorNamed: @"venetianRed"] CGColor];
    }
    if ([login isEqual: @"username"] && [pass isEqual: @"password"]) {
        self.loginField.layer.borderColor = [[UIColor colorNamed: @"turquoiseGreen"] CGColor];
        self.passField.layer.borderColor = [[UIColor colorNamed: @"turquoiseGreen"] CGColor];
    }
    NSLog(@"tap");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end