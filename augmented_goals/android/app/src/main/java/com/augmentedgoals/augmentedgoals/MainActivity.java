package com.augmentedgoals.augmentedgoals;

import android.content.ContentResolver;
import android.content.Context;
import android.os.Bundle;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    private static String resourceToUriString(Context context, int resId) {
        return
                ContentResolver.SCHEME_ANDROID_RESOURCE
                        + "://"
                        + context.getResources().getResourcePackageName(resId)
                        + "/"
                        + context.getResources().getResourceTypeName(resId)
                        + "/"
                        + context.getResources().getResourceEntryName(resId);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        new MethodChannel(getFlutterView(), "augmentedgoals.augmentedgoals.com/resourceResolver").setMethodCallHandler(
                (call, result) -> {
                    if ("drawableToUri".equals(call.method)) {
                        int resourceId = MainActivity.this.getResources().getIdentifier((String) call.arguments, "drawable", MainActivity.this.getPackageName());
                        String uriString = resourceToUriString(MainActivity.this.getApplicationContext(), resourceId);
                        result.success(uriString);
                    }
                });
    }
}


// Old Sensor code from onCreate
/*
    private static final String STREAM = "augmentedgoal.com/light";
    @TargetApi(Build.VERSION_CODES.CUPCAKE)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        SensorManager sensorManager = (SensorManager) getSystemService(SENSOR_SERVICE);

        new EventChannel(getFlutterView(), STREAM).setStreamHandler(
                new EventChannel.StreamHandler() {
                    SensorEventListener lightSensorListener;
                    @Override
                    public void onListen(Object args, final EventChannel.EventSink events) {
                        lightSensorListener = new SensorEventListener() {
                            @Override
                            public void onSensorChanged(SensorEvent event) {
                                events.success(event.values[0]);
                            }
                            @Override
                            public void onAccuracyChanged(Sensor sensor, int accuracy) {

                            }
                        };
                        Sensor LightSensor = null;
                        if (sensorManager != null) {
                            LightSensor = sensorManager.getDefaultSensor(Sensor.TYPE_LIGHT);
                        }
                        if (LightSensor != null) {
                            sensorManager.registerListener(
                                    lightSensorListener,
                                    LightSensor,
                                    SensorManager.SENSOR_DELAY_UI);
                        }
                    }
                    @Override
                    public void onCancel(Object o) {
                        if (sensorManager != null) {
                            sensorManager.unregisterListener(lightSensorListener);
                        }
                    }
                }
        );
    }*/
