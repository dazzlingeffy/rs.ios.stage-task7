//
//  AuthViewController.m
//  AuthScreen
//
//  Created by ira on 04.07.2021.
//

#import "AuthViewController.h"
#import "UIButtonBackgroundColor.h"

@interface AuthViewController () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *loginField;
@property (strong, nonatomic) IBOutlet UITextField *passField;
@property (strong, nonatomic) IBOutlet UILabel *secureField;
@property (strong, nonatomic) IBOutlet UIStackView *secureStack;
@property (strong, nonatomic) IBOutlet UIButton *authBtn;
@property (strong, nonatomic) IBOutlet UIView *secureView;
@property (strong, nonatomic) IBOutlet UIAlertController *alert;

@end

@interface AuthViewController (KeyboardHandling)
//- (void)subscribeOnKeyboardEvents;
//- (void)updateTopContraintWith:(CGFloat) constant andBottom:(CGFloat) bottomConstant;
- (void)hideWhenTappedAround;
@end

@implementation AuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // alert
    
    _alert = [UIAlertController alertControllerWithTitle:@"Welcome" message:@"You are successfuly authorized!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Refresh" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
        self.loginField.text = @"";
        self.loginField.layer.borderColor = [[UIColor colorNamed: @"blackCoral"] CGColor];
        self.passField.text = @"";
        self.passField.layer.borderColor = [[UIColor colorNamed: @"blackCoral"] CGColor];
        self.secureField.text = @"_";
        [self.secureView removeFromSuperview];
        self.loginField.enabled = YES;
        self.loginField.alpha = 1;
        self.passField.enabled = YES;
        self.passField.alpha = 1;
        self.authBtn.enabled = YES;
        self.authBtn.alpha = 1;
    }];
    [_alert addAction:alertAction];
    
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
    _loginField.delegate = self;
    
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
    _passField.delegate = self;
    
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
    _authBtn.clipsToBounds = YES;
    
    // add image to btn
    
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
    
    // secure vstack
    _secureView = [[UIView alloc] initWithFrame:CGRectMake(0, btnMargin + 67, 236, 130)];
    _secureStack = [[UIStackView alloc] initWithFrame:CGRectMake(0, 0, 236, 110)];
    
    _secureStack.axis = UILayoutConstraintAxisVertical;
    _secureStack.distribution = UIStackViewDistributionEqualCentering;
    _secureStack.alignment = UIStackViewAlignmentCenter;
    _secureStack.spacing = 20;
    [_secureView setCenter: CGPointMake(self.view.center.x, _secureView.center.y)];
    
    
    // secure code field
//    CGFloat secureMargin = btnMargin + 80;
    _secureField = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 100, 40)];
    _secureField.text = @"_";
    _secureField.font = [UIFont systemFontOfSize:18 weight:UIFontWeightSemibold];
    [_secureField setTextAlignment:NSTextAlignmentCenter];
    [_secureField setCenter: CGPointMake(self.view.center.x, _secureField.center.y)];
    [_secureField.heightAnchor constraintEqualToConstant:100].active = true;
    [_secureField.widthAnchor constraintEqualToConstant:70].active = true;
    
    [_secureStack addArrangedSubview:_secureField];
    
    // secure code buttons

    UIStackView *btnStack = [[UIStackView alloc] init];

    btnStack.axis = UILayoutConstraintAxisHorizontal;
    btnStack.distribution = UIStackViewDistributionEqualSpacing;
    btnStack.alignment = UIStackViewAlignmentCenter;
    btnStack.spacing = 20;

    UIButton *btnOne = [UIButton buttonWithType:UIButtonTypeCustom];
    btnOne.frame = CGRectMake(0, 0, 50, 50);
    btnOne.titleLabel.font = [UIFont systemFontOfSize:24 weight:UIFontWeightSemibold];
    [btnOne setTitle:@"1" forState:UIControlStateNormal];
    [btnOne setTitleColor: [UIColor colorNamed: @"littleBoyBlue"] forState:UIControlStateNormal];
    [btnOne setBackgroundColor:[UIColor colorNamed:@"white"]];
    [btnOne.heightAnchor constraintEqualToConstant:50].active = true;
    [btnOne.widthAnchor constraintEqualToConstant:50].active = true;

    btnOne.layer.borderColor = [[UIColor colorNamed: @"littleBoyBlue"] CGColor];
    btnOne.layer.borderWidth = 1.5;
    btnOne.layer.cornerRadius = 25;
    btnOne.clipsToBounds = YES;
    [btnOne setBackgroundColor:[[UIColor colorNamed:@"littleBoyBlue"] colorWithAlphaComponent:0.2] forState:UIControlStateHighlighted];
    
    UIButton *btnTwo = [UIButton buttonWithType:UIButtonTypeCustom];
    btnTwo.frame = CGRectMake(0, 0, 50, 50);
    btnTwo.titleLabel.font = [UIFont systemFontOfSize:24 weight:UIFontWeightSemibold];
    [btnTwo setTitle:@"2" forState:UIControlStateNormal];
    [btnTwo setTitleColor: [UIColor colorNamed: @"littleBoyBlue"] forState:UIControlStateNormal];
    [btnTwo setBackgroundColor:[UIColor colorNamed:@"white"]];
    [btnTwo.heightAnchor constraintEqualToConstant:50].active = true;
    [btnTwo.widthAnchor constraintEqualToConstant:50].active = true;
    [btnTwo setBackgroundColor:[[UIColor colorNamed:@"littleBoyBlue"] colorWithAlphaComponent:0.2] forState:UIControlStateHighlighted];

    btnTwo.layer.borderColor = [[UIColor colorNamed: @"littleBoyBlue"] CGColor];
    btnTwo.layer.borderWidth = 1.5;
    btnTwo.layer.cornerRadius = 25;
    btnTwo.clipsToBounds = YES;
    
    UIButton *btnThree = [UIButton buttonWithType:UIButtonTypeCustom];
    btnThree.frame = CGRectMake(0, 0, 50, 50);
    btnThree.titleLabel.font = [UIFont systemFontOfSize:24 weight:UIFontWeightSemibold];
    [btnThree setTitle:@"3" forState:UIControlStateNormal];
    [btnThree setTitleColor: [UIColor colorNamed: @"littleBoyBlue"] forState:UIControlStateNormal];
    [btnThree setBackgroundColor:[UIColor colorNamed:@"white"]];
    [btnThree.heightAnchor constraintEqualToConstant:50].active = true;
    [btnThree.widthAnchor constraintEqualToConstant:50].active = true;
    [btnThree setBackgroundColor:[[UIColor colorNamed:@"littleBoyBlue"] colorWithAlphaComponent:0.2] forState:UIControlStateHighlighted];

    btnThree.layer.borderColor = [[UIColor colorNamed: @"littleBoyBlue"] CGColor];
    btnThree.layer.borderWidth = 1.5;
    btnThree.layer.cornerRadius = 25;
    btnThree.clipsToBounds = YES;
    
    // add btns target
    
    [btnOne addTarget:self action:@selector(numBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [btnTwo addTarget:self action:@selector(numBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [btnThree addTarget:self action:@selector(numBtnTapped:) forControlEvents:UIControlEventTouchUpInside];

    [btnStack addArrangedSubview:btnOne];
    [btnStack addArrangedSubview:btnTwo];
    [btnStack addArrangedSubview:btnThree];
    [_secureStack addArrangedSubview:btnStack];
//    _secureStack.translatesAutoresizingMaskIntoConstraints = false;
    [_secureView addSubview:_secureStack];
//    [self.view addSubview:_secureView];
    
    [self hideWhenTappedAround];
}

- (void)authBtnTapped:(UIButton *)sender {
    NSString *login = self.loginField.text;
    NSString *pass = self.passField.text;
    
    if (![login  isEqual: @"username"]) {
        self.loginField.layer.borderColor = [[UIColor colorNamed: @"venetianRed"] CGColor];
    } else {
        self.loginField.layer.borderColor = [[UIColor colorNamed: @"turquoiseGreen"] CGColor];
    }
    if (![pass isEqual: @"password"]) {
        self.passField.layer.borderColor = [[UIColor colorNamed: @"venetianRed"] CGColor];
    } else {
        self.passField.layer.borderColor = [[UIColor colorNamed: @"turquoiseGreen"] CGColor];
    }
    if ([login isEqual: @"username"] && [pass isEqual: @"password"]) {
        self.loginField.enabled = NO;
        self.loginField.alpha = 0.5;
        self.passField.enabled = NO;
        self.passField.alpha = 0.5;
        self.authBtn.enabled = NO;
        self.authBtn.alpha = 0.4;
        [self.view addSubview: self.secureView];
    }
}

-(void)numBtnTapped:(UIButton *)sender {
    if ([self.secureField.text isEqual:@"_"]) {
        _secureView.layer.borderColor = nil;
        _secureView.layer.borderWidth = 0;
        _secureView.layer.cornerRadius = 0;
        self.secureField.text = sender.titleLabel.text;
    } else if (![self.secureField.text isEqual:@"_"] && self.secureField.text.length < 5) {
        self.secureField.text = [NSString stringWithFormat:@"%@ %@", self.secureField.text, sender.titleLabel.text];
    }
    if (self.secureField.text.length == 5) {
        if ([self.secureField.text isEqual:@"1 3 2"]) {
            _secureView.layer.borderColor = [[UIColor colorNamed:@"turquoiseGreen"] CGColor];
            _secureView.layer.borderWidth = 3;
            _secureView.layer.cornerRadius = 10;
            [self presentViewController:self.alert animated:YES completion:nil];
        } else {
            _secureView.layer.borderColor = [[UIColor colorNamed:@"venetianRed"] CGColor];
            _secureView.layer.borderWidth = 3;
            _secureView.layer.cornerRadius = 10;
            self.secureField.text = @"_";
        }
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField == self.loginField)
    {

        NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];
        for (int i = 0; i < [string length]; i++)
        {
            unichar c = [string characterAtIndex:i];
            if (![myCharSet characterIsMember:c])
            {
                return NO;
            }
        }

        return YES;
    }

    return YES;
}

-(void)textFieldDidBeginEditing: (UITextField *)textField
{
    textField.layer.borderColor = [[UIColor colorNamed: @"blackCoral"] CGColor];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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

@implementation AuthViewController (KeyboardHandling)

//- (void)subscribeOnKeyboardEvents {
//    // Keyboard will show
//    [NSNotificationCenter.defaultCenter addObserver:self
//                                           selector:@selector(keybaordWillShow:)
//                                               name:UIKeyboardWillShowNotification
//                                             object:nil];
//    // Keyboard will hide
//    [NSNotificationCenter.defaultCenter addObserver:self
//                                           selector:@selector(keybaordWillHide:)
//                                               name:UIKeyboardWillHideNotification
//                                             object:nil];
//}

- (void)hideWhenTappedAround {
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                               action:@selector(hide)];
    [self.view addGestureRecognizer:gesture];
}

- (void)hide {
    [self.view endEditing:true];
}

//- (void)keybaordWillShow:(NSNotification *)notification {
//    CGRect rect = [(NSValue *)notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//
//    [self updateTopContraintWith:15.0 andBottom:rect.size.height - self.view.safeAreaInsets.bottom + 15.0];
//}

//- (void)keybaordWillHide:(NSNotification *)notification {
//    [self updateTopContraintWith:200.0 andBottom:0.0];
//}

//- (void)updateTopContraintWith:(CGFloat) constant andBottom:(CGFloat) bottomConstant {
//    // Change your constraint constants
//    self.topContraint.constant = constant;
//    self.bottomContraint.constant = bottomConstant;
//    [UIView animateWithDuration:0.2 animations:^{
//        [self.view layoutIfNeeded];
//    }];
//}

@end
