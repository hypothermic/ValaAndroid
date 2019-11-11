#include <jni.h>
#include <string>

#include "MyLibHeader.h"

extern "C" JNIEXPORT jstring JNICALL
Java_nl_hypothermic_valadroid_MainActivity_stringFromJNI(
        JNIEnv *env,
        jobject /* this */) {
    return env->NewStringUTF(vala_main());
}
