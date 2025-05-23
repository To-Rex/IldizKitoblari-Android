# just_audio va ExoPlayer uchun qoidalar
-keep class com.google.android.exoplayer2.** { *; }
-keep class com.ryanheise.** { *; }
-dontwarn com.google.android.exoplayer2.**
# Flutter va boshqa zarur sinflar
-keep class io.flutter.** { *; }
-dontwarn io.flutter.**