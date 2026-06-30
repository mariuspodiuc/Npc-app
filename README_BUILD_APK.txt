NCP Mechanical Android APK Project

What this is:
- Android WebView app wrapping the NCP Mechanical Pro Portal.
- Works offline because the web files are inside the APK assets.
- Uses Android date picker from the existing HTML date fields.
- Supports evidence file upload through Android file picker.
- Supports PDF export through Android print / Save as PDF.

Build APK using Android Studio:
1. Install Android Studio.
2. Open this folder: NCP_Mechanical_Android_App
3. Wait for Gradle sync to finish.
4. Click Build > Build Bundle(s) / APK(s) > Build APK(s).
5. APK location:
   app/build/outputs/apk/debug/app-debug.apk

Build APK using GitHub Actions:
1. Upload this folder to a GitHub repository.
2. Go to Actions > Build Android APK.
3. Press Run workflow.
4. Download the APK from Artifacts.

Package name:
com.ncpmechanical.portal

App name:
NCP Mechanical
