# UpSkill Consultancy App — 30-Step Development Plan

## App Structure

- Platform: Flutter — Android and iOS
- Coding Tool: Antigravity
- Design: Simple, modern and user-friendly
- Colors: Original UC blue, charcoal and white
- Heading Font: Poppins
- Body Font: Inter
- Bengali Font: Noto Sans Bengali
- Themes: Light, Dark and System
- Languages: English and Bengali

## Bottom Navigation

Home → Courses → My Learning → Services → Dashboard

My Learning will be the center floating navigation button.

## Phase 1 — UI Development

### Step 01 — Project Setup
- Create the Flutter project.
- Set up feature-based folders, routing and state management.
- Use mock data during UI development.

### Step 02 — Colors and Typography
- Configure original UC brand colors.
- Use Poppins for titles and Inter for body text.
- Define consistent font sizes, spacing and corner radius.

### Step 03 — Themes and Localization
- Add Light, Dark and System themes.
- Add English and Bengali support.
- Save language and theme preferences.

### Step 04 — Reusable Components
- Create buttons, text fields, course cards and section headings.
- Add loading, empty and error components.
- Keep layouts consistent across screens.

### Step 05 — Bottom Navigation
- Add Home, Courses, My Learning, Services and Dashboard.
- Make My Learning the center floating button.
- Preserve each tab’s navigation state.

### Step 06 — Splash Screen
- Display the animated UC logo.
- Check onboarding and login status.
- Navigate to the correct starting screen.

### Step 07 — Onboarding
- Download suitable, licensed onboarding images.
- Create three short onboarding screens.
- Add Skip, Next and Get Started buttons.

### Step 08 — Guest Mode
- Allow browsing Home, Courses, subscription plans and Services.
- Require login for personal learning features.
- Return users to their intended action after login.

### Step 09 — Login and Registration
- Create Login and Create Account screens.
- Add form validation and password visibility controls.
- Include privacy and terms links.

### Step 10 — Password Recovery
- Create Forgot Password and Reset Password screens.
- Add request confirmation and success states.
- Prepare verification screens if required by authentication.

### Step 11 — Home App Bar
- Show the UC logo and UpSkill Consultancy name.
- Add notification and profile icons.
- Keep the app bar compact.

### Step 12 — Home Announcements
- Place announcements at the start of Home.
- Use a compact card with minimal text.
- Open the related screen when tapped.

### Step 13 — Home Top Courses
- Show Top Courses below announcements.
- Use horizontal course cards.
- Add a View All action.

### Step 14 — Home Featured Courses
- Show Featured Courses below Top Courses.
- Display image, title and essential course information.
- Open course details on tap.

### Step 15 — Home Continue Learning
- Show Continue Learning for students with an active course.
- Display progress and a Resume button.
- Hide the section when there is no course to continue.

### Step 16 — Home Practice Tools and Categories
- Add shortcuts to available practice tools.
- Show course categories below the tools.
- Open the selected tool or filtered course list.

### Step 17 — Courses Tab
- Display the complete course catalog.
- Add search and category filters.
- Include loading, no-results and empty states.

### Step 18 — Course Details
- Show overview, curriculum, duration and instructor.
- Display three actual learning benefits.
- Show Start Learning or View Plans based on access.

### Step 19 — Subscription Plans
- Create three subscription plan cards, including Basic.
- Show each plan’s approved price, duration and benefits.
- Highlight the current plan.
- Use confirmed names for the other two plans.
- Do not add individual course purchases.

### Step 20 — My Learning
- Display the student’s courses.
- Add In Progress and Completed filters.
- Show progress and Continue Learning actions.
- Include guest, locked and empty states.

### Step 21 — Lesson and Video Screen
- Add video playback and a module/lesson list.
- Include Next Lesson and completion controls.
- Display learning resources and playback progress.

### Step 22 — Practice Tool Screens
- Create the available practice-tool screens.
- Add clear instructions and relevant inputs.
- Show results and retry/reset actions where applicable.

### Step 23 — Services and Contact
- Display consultancy and enterprise services.
- Create service details screens.
- Add Contact for Service to every service.
- Create an inquiry form and confirmation screen.

### Step 24 — Student Dashboard
- Show learning overview and subscription status.
- Add profile editing and account settings.
- Include language, theme, logout and account deletion.

### Step 25 — Notifications, Support and UI Review
- Create notification list and notification details navigation.
- Add support, privacy policy and terms screens.
- Review all UI flows using mock data.
- Check small screens, dark mode and Bengali text.

## Phase 2 — API Integration

### Step 26 — Authentication APIs
- Connect supported Wix login and registration flows.
- Integrate password recovery and verification.
- Handle secure sessions, token expiry and logout.

### Step 27 — Home and Course APIs
- Connect announcements, top courses and featured courses.
- Integrate categories, course search and course details.
- Add pagination and network error handling.

### Step 28 — Student Portal and Service APIs
- Connect My Learning, lessons, resources and progress.
- Integrate practice tools, profile and notifications.
- Connect services and inquiry submission.
- Synchronize existing subscription access.
- Enforce protected course access on the backend.

## Phase 3 — In-App Purchase and Release

### Step 29 — Subscription In-App Purchase
- Configure the three approved subscription products.
- Integrate purchase and restore flows.
- Verify purchases on the backend.
- Synchronize mobile purchases with the student’s account.
- Handle pending, renewed, cancelled and expired subscriptions.

### Step 30 — Final Testing and Release
- Test guest, login and subscriber journeys.
- Verify purchases, restoration and course access.
- Test video playback, progress saving and slow connections.
- Fix Android and iOS issues.
- Prepare store screenshots, production builds and submission.

## Home Section Order

1. App Bar — UC Logo, Name, Notifications and Profile
2. Announcements
3. Top Courses
4. Featured Courses
5. Continue Learning — when available
6. Practice Tools
7. Course Categories

## Business Rules

- Courses are accessed through one of three subscription plans.
- Plan names, prices and course limits must match approved business rules.
- Services require a contact or inquiry action.
- My Learning is the main Student Portal learning area.
- Confirm Wix API coverage and purchase synchronization requirements early.
- Complete UI first, then API integration, then In-App Purchase.