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

    static uint8_t gy85_buff[6 + 6 + 8];

    //x-y-z axis[0]=10 axis[1]=32 axis[2]=54
    GY85.read_acclerometer_raw(gy85_buff);
    //x-y-z axis[0]=01 axis[1]=45 axis[2]=34
    GY85.read_compass_raw(gy85_buff + 6);
    //x-y-z-temp axis[0]=45 axis[1]=23 axis=[2]=67 axis[4]=01
    GY85.read_gyro_raw(gy85_buff + 6 + 6);

    //acc x y z [1,0] [3,2] [5,4]
    //compass x y z [6,7] [10,11] [8,9]
    //gyro x y z t [16,17] [14,15] [18,19] [12,13]

    if (Serial.availableForWrite() > 20)
    {
        Serial.write(gy85_buff, 20);
    }
}
