// Unity built-in shader source. Copyright (c) 2016 Unity Technologies. MIT license (see license.txt)

Shader "Sprites/Angle Gradient"
{
    Properties
    {
        _ColorCount ("Number of Colors", float) = 2
        _CenterX ("Center X", float) = 0.5
        _CenterY ("Center Y", float) = 0.5
        _Aspect ("Aspect", float) = 1
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
            float _Aspect;

            fixed4 gradientFrag (v2f IN) : SV_Target
            {
                float2 uv = IN.texcoord;

                float2 d = float2((_CenterX - uv.x) * _Aspect, _CenterY - uv.y);
                float angle = angleOf (d);

                return sampleGradientColor (_GradientColors, _GradientPosition, _ColorCount, angle * INVERSE_DOUBLE_PI) * IN.color * IN.color.a;
            }
        ENDCG
        }
    }
}
