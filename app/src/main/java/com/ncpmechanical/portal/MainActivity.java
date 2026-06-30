package com.ncpmechanical.portal;
import android.app.Activity;import android.os.Bundle;import android.webkit.*;import android.view.View;import android.graphics.Color;
public class MainActivity extends Activity{
 WebView web;
 public void onCreate(Bundle b){super.onCreate(b);web=new WebView(this);setContentView(web);getWindow().setStatusBarColor(Color.WHITE);WebSettings s=web.getSettings();s.setJavaScriptEnabled(true);s.setDomStorageEnabled(true);s.setAllowFileAccess(true);s.setAllowContentAccess(true);s.setMediaPlaybackRequiresUserGesture(false);web.setWebChromeClient(new WebChromeClient());web.setWebViewClient(new WebViewClient());web.loadUrl("file:///android_asset/web/index.html");}
 public void onBackPressed(){if(web!=null&&web.canGoBack())web.goBack();else super.onBackPressed();}
}
