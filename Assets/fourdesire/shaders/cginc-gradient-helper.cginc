#ifndef CGINC_GRADIENT_HELPER_INCLUDED
#define CGINC_GRADIENT_HELPER_INCLUDED

#ifndef PI
#define PI 3.141592653589793
#endif

#ifndef DOUBLE_PI
#define DOUBLE_PI 6.2831853072
#endif

#ifndef HALF_PI
#define HALF_PI 1.5707963267948966
#endif

#ifndef INVERSE_DOUBLE_PI
#define INVERSE_DOUBLE_PI 0.1591549431
#endif

#ifndef DEGREE_2_RADIAN 
#define DEGREE_2_RADIAN 0.01745329252
#endif

inline fixed4 sampleGradientColor(fixed4 colors [5], float positions [5], int count, float t) 
{
    for (int p = 0; p < count; p++) {

        if (t <= positions [p]) {

            if (p == 0) {

                return colors [0];

            } else {

                return lerp(colors [p - 1], colors [p], (t - positions [p - 1]) / (positions [p] - positions [p - 1]));
            }

        } else if (p == count - 1) {

            return colors [p];
        }
    }

    return (0,0,0,0);
}

inline float2 rotateUV (fixed2 uv, float rotation) 
{
    float sinX = sin (rotation);
    float cosX = cos (rotation);
    float2x2 rotationMatrix = float2x2( cosX, -sinX, sinX, cosX);
    return mul (uv - fixed2 (0.5, 0.5), rotationMatrix) + fixed2 (0.5, 0.5);
}

inline float angleOf (float2 vec) 
{
    if (vec.x == 0 && vec.y == 0) return 0;

    float d = sqrt (vec.x*vec.x + vec.y*vec.y);

    if (vec.y > 0) {

        return acos(vec.x / d);

    } else {

        return DOUBLE_PI - acos(vec.x / d);
    }
}

#endif