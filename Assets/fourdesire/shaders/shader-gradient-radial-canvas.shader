// Unity built-in shader source. Copyright (c) 2016 Unity Technologies. MIT license (see license.txt)

Shader "Sprites/Radial Gradient"
{
    Properties
    {
        _ColorCount ("Number of Colors", float) = 2
        _CenterX ("Center X", float) = 0.5
        _CenterY ("Center Y", float) = 0.5
        _AspectX ("Aspect X", float) = 1
        _AspectY ("Aspect Y", float) = 1
        [PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
        _Color ("Tint", Color) = (1,1,1,1)
        [MaterialToggle] PixelSnap ("Pixel snap", Float) = 0
        [HideInInspector] _RendererColor ("RendererColor", Color) = (1,1,1,1)
        [HideInInspector] _Flip ("Flip", Vector) = (1,1,1,1)
        [PerRendererData] _AlphaTex ("External Alpha", 2D) = "white" {}
        [PerRendererData] _EnableExternalAlpha ("Enable External Alpha", Float) = 0
    }

    SubShader
    {
        Tags
        {
            "Queue"="Transparent"
            "IgnoreProjector"="True"
            "RenderType"="Transparent"
            "PreviewType"="Plane"
            "CanUseSpriteAtlas"="True"
        }

        Cull Off
        Lighting Off
        ZWrite Off
        Blend One OneMinusSrcAlpha

        Pass
        {
        CGPROGRAM
            #pragma vertex SpriteVert
            #pragma fragment gradientFrag
            #pragma target 2.0
            #pragma multi_compile_instancing
            #pragma multi_compile _ PIXELSNAP_ON
            #pragma multi_compile _ ETC1_EXTERNAL_ALPHA
            #include "UnitySprites.cginc"
            #include "cginc-gradient-helper.cginc"

            float _ColorCount;
            fixed4 _GradientColors[5];
            float _GradientPosition[5];
            float _CenterX;
            float _CenterY;
            float _AspectX;
            float _AspectY;

            fixed4 gradientFrag (v2f IN) : SV_Target
            {
                float2 uv = IN.texcoord;
                float2 d = float2 ((_CenterX - uv.x) * _AspectX, (_CenterY - uv.y) * _AspectY);
                return sampleGradientColor (_GradientColors, _GradientPosition, _ColorCount, sqrt(d.x*d.x + d.y*d.y) * 2) * IN.color * IN.color.a;

                /*
                float2 uv = i.texcoord;
                float2 scale = float2 (unity_ObjectToWorld [0][0], unity_ObjectToWorld [1][1]);

                float2 d;

                if (scale.x == scale.y) {

                    d.x = (_CenterX - uv.x);
                    d.y = (_CenterY - uv.y);

                } else if (scale.x > scale.y) {

                    d.x = (_CenterX - uv.x) * scale.x / scale.y;
                    d.y = _CenterY - uv.y;

                } else {

                    d.x = (_CenterX - uv.x);
                    d.y = (_CenterY - uv.y) * scale.y / scale.x;
                }

                d *= float2 (_AspectX, _AspectY);

                return sampleGradientColor (_GradientColors, _GradientPosition, _ColorCount, sqrt(d.x*d.x + d.y*d.y) * 2) * _TintColor;*/
            }
        ENDCG
        }
    }
}
