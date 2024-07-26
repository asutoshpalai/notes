#  Oculus VrSample

Here I am logging my findings from exploring the code in VrSample and VrApi of
[Mobile SDK](https://developer.oculus.com/downloads/package/oculus-mobile-sdk/).

## JNI
- Until a thread is attached, it has no JNIEnv, and cannot make JNI calls. Ref:
    <https://developer.android.com/training/articles/perf-jni>
- Lifecycle of the app has to be listened through a handler
    (`VrSamples/SampleFramework/Src/Appl.cpp#android_handle_cmd`)


## SampleFramework
- `/Src/Appl.cpp` - handles the Android and Oculus specific setup.


## Takeaways
- CPU and GPU levels can be adjusted for performance and power consumption.
