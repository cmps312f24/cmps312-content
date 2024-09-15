// if, else if
if (user is Admin) {
  return AdminDashboard();
} else if (user is VerifiedUser) {
  return UserHome();
} else {
  return WelcomeScreen();
}

// Type Matching 
switch (user) {
  case Admin admin:
    return AdminDashboard(admin);
  case VerifiedUser verifiedUser:
    return UserHome(verifiedUser);
  default:
    return WelcomeScreen();
}