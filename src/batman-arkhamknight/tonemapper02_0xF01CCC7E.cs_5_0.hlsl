// motion blur + effect

#include "../common/Open_DRT.hlsl"
#include "../common/aces.hlsl"
#include "../common/color.hlsl"
#include "./shared.h"

Texture2D<float4> t0 : register(t0);
Texture2D<float4> t1 : register(t1);
Texture2D<float4> t2 : register(t2);
Texture2D<float4> t3 : register(t3);
Texture2D<float4> t4 : register(t4);
Texture2D<float4> t5 : register(t5);
Texture2D<float4> t6 : register(t6);

SamplerState s0_s : register(s0);

RWTexture2D<float4> u0 : register(u0);

cbuffer cb0 : register(b0) {
  float4 cb0[13];
}

cbuffer cb13 : register(b13) {
  ShaderInjectData injectedData : packoffset(c0);
}

// 3Dmigoto declarations
#define cmp -

[numthreads(16, 16, 1)] void main(uint3 vThreadGroupID : SV_GroupID, uint3 vThreadID : SV_DispatchThreadID) {
  // Needs manual fix for instruction:
  // unknown dcl_: dcl_uav_typed_texture2d (float,float,float,float) u0
  float4 r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10;

  // Needs manual fix for instruction:
  // unknown dcl_: dcl_thread_group 16, 16, 1
  r0.xy = float2(2, -2) / cb0[6].xy;
  r1.xy = vThreadGroupID.xy;
  r1.zw = float2(0, 0);
  r1.xyz = t6.Load(r1.xyz).xyz;
  r0.zw = cmp(float2(3, 0) < r1.zz);
  r0.w = r0.w ? 0.000000 : 0;
  r0.z = r0.z ? 2 : r0.w;
  r1.zw = (int2)vThreadID.xy;
  r1.zw = cb0[7].zw + r1.zw;
  r2.xy = (uint2)r1.zw;
  r3.xyzw = (uint4)r2.xyyx;
  r1.zw = -cb0[7].zw + r3.wz;
  r1.zw = float2(0.5, 0.5) + r1.zw;
  r0.xy = r1.zw * r0.xy + float2(-1, 1);
  r0.xy = r0.xy * float2(0.5, -0.5) + float2(0.5, 0.5);
  r1.zw = cb0[7].xy * r0.xy;
  r2.zw = float2(0, 0);
  const float4 texture0Input = t0.Load(r2.xyw);
  r4.xyz = texture0Input.rgb;

  r3.xyzw = cb0[11].xyxx + r3.xyzw;
  r0.w = dot(r3.wyz, float3(23.1406918, 2.66514421, 9.19949627));
  r0.w = cos(r0.w);
  r3.xyzw = r0.wwww * r3.xyzw;
  r3.xyzw = frac(r3.xyzw);
  if (r0.z != 0) {
    r5.xyz = t1.Load(r2.xyw).xyz;
    r0.w = dot(r5.xy, r5.xy);
    r4.w = (uint)r0.z;
    r4.w = 1 + r4.w;
    r4.w = rcp(r4.w);
    r6.xy = float2(0.5, 0.5) / cb0[6].xy;
    r7.zw = float2(0, 0);
    r8.xyz = r4.xyz;
    r5.w = 1;
    r6.z = 1;
    while (true) {
      r6.w = cmp((uint)r0.z < (uint)r6.z);
      if (r6.w != 0) break;
      r6.w = (int)r6.z & 1;
      r8.w = (uint)r6.z;
      r8.w = r8.w * r4.w;
      r9.xy = r6.ww ? r1.xy : r5.xy;
      r6.w = 0.5 * r8.w;
      r9.xy = r9.xy * r6.ww;
      r9.zw = r0.xy * cb0[7].xy + r9.xy;
      r10.xy = r9.zw / cb0[7].xy;
      r10.xy = r10.xy + -r6.xy;
      r10.xy = cb0[6].xy * r10.xy;
      r7.xy = (uint2)r10.xy;
      r10.xyz = t1.Load(r7.xyw).xyz;
      r6.w = r10.z + -r5.z;
      r6.w = saturate(-r6.w * 200 + 1);
      r8.w = -r10.z + r5.z;
      r8.w = saturate(-r8.w * 200 + 1);
      r9.x = dot(r9.xy, r9.xy);
      r9.y = dot(r10.xy, r10.xy);
      r10.x = cmp(r9.x < r9.y);
      r10.x = r10.x ? 1.000000 : 0;
      r9.zw = r0.xy * cb0[7].xy + -r9.zw;
      r9.z = dot(r9.zw, r9.zw);
      r9.z = cmp(r9.z < r0.w);
      r9.z = r9.z ? 1.000000 : 0;
      r8.w = r9.z * r8.w;
      r6.w = r6.w * r10.x + r8.w;
      r8.w = min(r9.y, r0.w);
      r8.w = sqrt(r8.w);
      r9.y = 0.00100000005 + r8.w;
      r9.x = sqrt(r9.x);
      r9.x = -r8.w * 0.949999988 + r9.x;
      r8.w = -r8.w * 0.949999988 + r9.y;
      r8.w = max(0.00100000005, r8.w);
      r8.w = saturate(r9.x / r8.w);
      r6.w = -r8.w + r6.w;
      r6.w = 1 + r6.w;
      r6.w = min(1, r6.w);
      r9.xyz = t0.Load(r7.xyz).xyz;
      r8.xyz = r9.xyz * r6.www + r8.xyz;
      r5.w = r6.w + r5.w;
      r6.z = (int)r6.z + 1;
    }
    r4.xyz = r8.xyz / r5.www;
  }
  r5.xyzw = t2.Load(r2.xyz).wxyz;  // Effect?
  r5.x = saturate(r5.x);
  r4.xyzw = cb0[12].xxxx * r4.zzxy;
  r0.z = 1 + -r5.x;
  r4.xyzw = r4.xyzw * r0.zzzz + r5.wwyz;

  r0.z = 0.200000003 * cb0[10].x;
  r1.xyz = t4.SampleLevel(s0_s, r1.zw, 0).xyz;  // Bloom
  r0.w = cb0[10].x * 0.200000003 + 1;
  r1.xyzw = r1.zzxy * r0.w - r0.z;
  r1.xyzw = max(float4(0, 0, 0, 0), r1.xyzw);
  r1.xyzw = r4.xyzw + r1.xyzw;

  const float3 bloomedInput = r1.zwy;

  r0.z = t5.SampleLevel(s0_s, float2(0.5, 0.5), 0).x;
  r1.xyzw = r1.xyzw / r0.zzzz;
  r0.xy = r0.xy * float2(2, 2) + float2(-1, -1);
  r0.xy = float2(0.769231021, 0.769231021) * r0.xy;
  r0.x = dot(r0.xy, r0.xy);
  r0.x = 1 + -r0.x;
  r0.x = max(0, r0.x);
  r0.x = r0.x * r0.x + -1;
  r0.x = r0.x * 0.300000012 + 1;
  r0.xyzw = r1.xyzw * r0.xxxx;
  r1.xyzw = r0.yyzw * float4(0.219999999, 0.219999999, 0.219999999, 0.219999999) + float4(0.0299999993, 0.0299999993, 0.0299999993, 0.0299999993);
  r1.xyzw = r0.yyzw * r1.xyzw + float4(0.00200000009, 0.00200000009, 0.00200000009, 0.00200000009);
  r4.xyzw = r0.yyzw * float4(0.219999999, 0.219999999, 0.219999999, 0.219999999) + float4(0.300000012, 0.300000012, 0.300000012, 0.300000012);
  r0.xyzw = r0.xyzw * r4.xyzw + float4(0.0599999987, 0.0599999987, 0.0599999987, 0.0599999987);
  r0.xyzw = r1.xyzw / r0.xyzw;
  r0.xyzw = float4(-0.0333333351, -0.0333333351, -0.0333333351, -0.0333333351) + r0.xyzw;
  r0.xyzw = max(float4(0, 0, 0, 0), r0.xyzw);
  r0.xyzw = float4(1.66289866, 1.66289866, 1.66289866, 1.66289866) * r0.xyzw;
  r0.xyzw = log2(r0.xyzw);
  r0.xyzw = float4(0.454545468, 0.454545468, 0.454545468, 0.454545468) * r0.xyzw;
  r0.xyzw = exp2(r0.xyzw);
  r0.xyzw = min(float4(1, 1, 1, 1), r0.xyzw);
  r1.xyw = float3(14.9998999, 0.9375, 0.05859375) * r0.xwz;
  r0.x = floor(r1.x);
  r0.y = r0.y * 15 + -r0.x;
  r1.x = r0.x * 0.0625 + r1.w;
  r1.xyzw = float4(0.001953125, 0.03125, 0.064453125, 0.03125) + r1.xyxy;
  r0.xzw = t3.SampleLevel(s0_s, r1.xy, 0).xyz;
  r1.xyz = t3.SampleLevel(s0_s, r1.zw, 0).xyz;
  r1.xyzw = r1.xyzx + -r0.xzwx;
  r0.xyzw = r0.yyyy * r1.xyzw + r0.xzwx;
  r1.xyzw = float4(1, 1, 1, 1) + -r0.wyzw;
  r1.xyzw = r1.xyzw * r1.xyzw;
  r1.xyzw = min(float4(1, 1, 1, 1), r1.xyzw);
  r1.xyzw = cb0[11].zzzz * r1.xyzw;
  r3.xyzw = float4(-0.333999991, -0.333999991, -0.333999991, -0.333999991) + r3.xyzw;
  r1.xyzw = r1.xyzw * r3.xyzw + float4(1, 1, 1, 1);
  r0.xyzw = r1.xyzw * r0.xyzw;

  float4 outputColor = r0.xyzw;
  outputColor.rgb = pow(abs(r0.rgb), 2.2f) * sign(r0.rgb);

  if (injectedData.toneMapperEnum == 0) {
    outputColor.rgb *= 203.f / 80.f;
  } else {
    if (injectedData.toneMapperEnum == 1) {
      outputColor.rgb = bloomedInput.rgb;  // Untonemapped
      outputColor.rgb *= injectedData.gamePaperWhite / 80.f;
    } else {
      float inputY = yFromBT709(bloomedInput.rgb);
      float outputY = yFromBT709(outputColor.rgb);
      outputColor.rgb *= (outputY ? inputY / outputY : 1);
      if (injectedData.toneMapperEnum == 2) {
        outputColor.rgb = aces_rrt_odt(
          outputColor.rgb * 203.f / 80.f,
          0.0001f,  // minY
          48.f * (injectedData.gamePeakWhite / injectedData.gamePaperWhite),
          AP1_2_BT2020_MAT
        );
      } else {
        outputColor.rgb = mul(BT709_2_BT2020_MAT, outputColor.rgb);
        outputColor.rgb = open_drt_transform_custom(
          outputColor.rgb * 203.f / 80.f,
          100.f * (injectedData.gamePeakWhite / injectedData.gamePaperWhite),
          0
        );
      }
      outputColor.rgb = mul(BT2020_2_BT709_MAT, outputColor.rgb);
      outputColor.rgb *= injectedData.gamePeakWhite / 80.f;
    }
  }

  u0[uint2(r2.x, r2.y)] = outputColor;
  // No code for instruction (needs manual fix):
  // store_uav_typed u0.xyzw, r2.xyyy, r0.xyzw
  return;
}
