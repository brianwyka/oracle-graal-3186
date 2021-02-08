# Oracle Graal Issue #3186

https://github.com/oracle/graal/issues/3186

## Reproduction

```sh
docker build .
```

### Error

```
09:12 $ docker build .
Sending build context to Docker daemon   48.9MB
Step 1/4 : FROM optum-docker-builders.bintray.io/nativeimage:graalvm-ce-21.0.0-java11
 ---> 6414bbe291e5
Step 2/4 : COPY native-image.jar /tmp/native-image.jar
 ---> 1eee76e57a27
Step 3/4 : WORKDIR /tmp
 ---> Running in 875036b52f8a
Removing intermediate container 875036b52f8a
 ---> 523d275ae76b
Step 4/4 : RUN native-image -cp native-image.jar     -H:+ReportExceptionStackTraces     --report-unsupported-elements-at-runtime     --no-fallback     --static
 ---> Running in 73fb984c3a42
[sourcehawk:26]    classlist:   4,752.19 ms,  0.96 GB
[sourcehawk:26]        (cap):     910.66 ms,  0.96 GB
[sourcehawk:26]        setup:   4,016.12 ms,  0.96 GB
[sourcehawk:26]     (clinit):   1,235.97 ms,  4.23 GB
[sourcehawk:26]   (typeflow):  61,288.01 ms,  4.23 GB
[sourcehawk:26]    (objects):  56,819.08 ms,  4.23 GB
[sourcehawk:26]   (features):   2,889.29 ms,  4.23 GB
[sourcehawk:26]     analysis: 125,600.70 ms,  4.23 GB
[sourcehawk:26]     universe:   2,954.35 ms,  4.23 GB
[sourcehawk:26]      (parse):  27,074.17 ms,  4.82 GB
[sourcehawk:26]     (inline):  17,329.65 ms,  5.42 GB
[sourcehawk:26]    (compile): 105,867.81 ms,  5.67 GB
[sourcehawk:26]      compile: 153,663.12 ms,  5.67 GB
[sourcehawk:26]        image:   6,073.65 ms,  5.67 GB
To see how the classes got initialized, use --trace-class-initialization=java.awt.Toolkit
[sourcehawk:26]        write:   1,310.75 ms,  5.67 GB
Error: Classes that should be initialized at run time got initialized during image building:
 java.awt.Toolkit was unintentionally initialized at build time. To see why java.awt.Toolkit got initialized use --trace-class-initialization=java.awt.Toolkit

com.oracle.svm.core.util.UserError$UserException: Classes that should be initialized at run time got initialized during image building:
 java.awt.Toolkit was unintentionally initialized at build time. To see why java.awt.Toolkit got initialized use --trace-class-initialization=java.awt.Toolkit

        at com.oracle.svm.core.util.UserError.abort(UserError.java:68)
        at com.oracle.svm.hosted.classinitialization.ConfigurableClassInitialization.checkDelayedInitialization(ConfigurableClassInitialization.java:539)
        at com.oracle.svm.hosted.classinitialization.ClassInitializationFeature.afterImageWrite(ClassInitializationFeature.java:340)
        at com.oracle.svm.hosted.NativeImageGenerator.lambda$doRun$6(NativeImageGenerator.java:691)
        at com.oracle.svm.hosted.FeatureHandler.forEachFeature(FeatureHandler.java:70)
        at com.oracle.svm.hosted.NativeImageGenerator.doRun(NativeImageGenerator.java:691)
        at com.oracle.svm.hosted.NativeImageGenerator.lambda$run$0(NativeImageGenerator.java:476)
        at java.base/java.util.concurrent.ForkJoinTask$AdaptedRunnableAction.exec(ForkJoinTask.java:1407)
        at java.base/java.util.concurrent.ForkJoinTask.doExec(ForkJoinTask.java:290)
        at java.base/java.util.concurrent.ForkJoinPool$WorkQueue.topLevelExec(ForkJoinPool.java:1020)
        at java.base/java.util.concurrent.ForkJoinPool.scan(ForkJoinPool.java:1656)
        at java.base/java.util.concurrent.ForkJoinPool.runWorker(ForkJoinPool.java:1594)
        at java.base/java.util.concurrent.ForkJoinWorkerThread.run(ForkJoinWorkerThread.java:183)
Error: Image build request failed with exit status 1
The command '/bin/sh -c native-image -cp native-image.jar     -H:+ReportExceptionStackTraces     --report-unsupported-elements-at-runtime     --no-fallback     --static' returned a non-zero code: 1
```
