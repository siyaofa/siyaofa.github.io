#include "GY_85.h"
#include <Wire.h>

GY_85 GY85; //create the object

void setup()
{
    Wire.begin();
    delay(10);
    Serial.begin(115200);
    delay(10);
    GY85.init();
    delay(10);
}

void loop()
{
    /* int ax = GY85.accelerometer_x( GY85.readFromAccelerometer() );
    int ay = GY85.accelerometer_y( GY85.readFromAccelerometer() );
    int az = GY85.accelerometer_z( GY85.readFromAccelerometer() );
    
    int cx = GY85.compass_x( GY85.readFromCompass() );
    int cy = GY85.compass_y( GY85.readFromCompass() );
    int cz = GY85.compass_z( GY85.readFromCompass() );

    float gx = GY85.gyro_x( GY85.readGyro() );
    float gy = GY85.gyro_y( GY85.readGyro() );
    float gz = GY85.gyro_z( GY85.readGyro() );
    float gt = GY85.temp  ( GY85.readGyro() ); */
//int ax = GY85.accelerometer_x( GY85.readFromAccelerometer());
    static int incomingByte = -1;
    static char rec_data[100];
    static uint8_t gy85_buff[6 + 6 + 8+20];

    //x-y-z axis[0]=10 axis[1]=32 axis[2]=54 
    GY85.read_acclerometer_raw(gy85_buff);
    //x-y-z axis[0]=01 axis[1]=45 axis[2]=34 
    GY85.read_compass_raw(gy85_buff + 6);
    //x-y-z-temp axis[0]=45 axis[1]=23 axis=[2]=67 axis[4]=01
    GY85.read_gyro_raw(gy85_buff + 6 + 6);

//acc-x y z [1,0] [3,2] [5,4]
//compass x y z [6,7] [10,11] [8,9]
//gyro x y z t [16,17] [14,15] [18,19] [12,13]

    while (Serial.available() > 0)
    {
        incomingByte = Serial.read();

        Serial.readBytes(rec_data, 100);
        Serial.flush();
       Serial.write(gy85_buff, 20);
         //Serial.println (12);
        /* //Serial.print  ( "accelerometer" );
    Serial.print  ( " x:" );
    Serial.print  ( ax );
    Serial.print  ( " y:" );
    Serial.print  ( ay );
    Serial.print  ( " z:" );
    Serial.print  ( az );
    
    //Serial.print  ( "  compass" );
    Serial.print  ( " x:" );
    Serial.print  ( cx );
    Serial.print  ( " y:" );
    Serial.print  ( cy );
    Serial.print  (" z:");
    Serial.print  ( cz );
    
    //Serial.print  ( "  gyro" );
    Serial.print  ( " x:" );
    Serial.print  ( gx );
    Serial.print  ( " y:" );
    Serial.print  ( gy );
    Serial.print  ( " z:" );
    Serial.println  ( gz );
//    Serial.print  ( " gyro temp:" );
//    Serial.println( gt ); */
    }

    //delay(100); // only read every 0,5 seconds, 10ms for 100Hz, 20ms for 50Hz
}
