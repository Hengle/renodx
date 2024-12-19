#include "./shared.h"
#include "./tonemapper.hlsl"

struct _EyeAdaptationBuffer {
  float data[4];
};
StructuredBuffer<_EyeAdaptationBuffer> EyeAdaptationBuffer : register(t0);

Texture2D<float4> ColorTexture : register(t1);

Texture2D<float4> BloomTexture : register(t2);

struct _SceneColorApplyParamaters {
  float data[4];
};
StructuredBuffer<_SceneColorApplyParamaters> SceneColorApplyParamaters : register(t3);

Texture3D<float4> LumBilateralGrid : register(t4);

Texture2D<float4> BlurredLogLum : register(t5);

Texture2D<float4> BloomDirtMaskTexture : register(t6);

Texture3D<float4> ColorGradingLUT : register(t7);

cbuffer _RootShaderParameters : register(b0) {
  float _RootShaderParameters_015x : packoffset(c015.x);
  float _RootShaderParameters_015y : packoffset(c015.y);
  float _RootShaderParameters_015z : packoffset(c015.z);
  float _RootShaderParameters_015w : packoffset(c015.w);
  float _RootShaderParameters_025y : packoffset(c025.y);
  float _RootShaderParameters_025z : packoffset(c025.z);
  float _RootShaderParameters_025w : packoffset(c025.w);
  float _RootShaderParameters_026x : packoffset(c026.x);
  float _RootShaderParameters_026y : packoffset(c026.y);
  float _RootShaderParameters_026z : packoffset(c026.z);
  float _RootShaderParameters_026w : packoffset(c026.w);
  float _RootShaderParameters_027x : packoffset(c027.x);
  float _RootShaderParameters_027z : packoffset(c027.z);
  float _RootShaderParameters_027w : packoffset(c027.w);
  float _RootShaderParameters_033x : packoffset(c033.x);
  float _RootShaderParameters_033y : packoffset(c033.y);
  float _RootShaderParameters_033z : packoffset(c033.z);
  float _RootShaderParameters_033w : packoffset(c033.w);
  float _RootShaderParameters_034x : packoffset(c034.x);
  float _RootShaderParameters_034y : packoffset(c034.y);
  float _RootShaderParameters_034z : packoffset(c034.z);
  float _RootShaderParameters_034w : packoffset(c034.w);
  float _RootShaderParameters_041x : packoffset(c041.x);
  float _RootShaderParameters_041y : packoffset(c041.y);
  float _RootShaderParameters_041z : packoffset(c041.z);
  float _RootShaderParameters_042x : packoffset(c042.x);
  float _RootShaderParameters_042y : packoffset(c042.y);
  float _RootShaderParameters_042z : packoffset(c042.z);
  float _RootShaderParameters_044x : packoffset(c044.x);
  float _RootShaderParameters_045x : packoffset(c045.x);
  float _RootShaderParameters_045y : packoffset(c045.y);
  float _RootShaderParameters_045z : packoffset(c045.z);
  float _RootShaderParameters_045w : packoffset(c045.w);
  float _RootShaderParameters_047z : packoffset(c047.z);
  float _RootShaderParameters_047w : packoffset(c047.w);
  float _RootShaderParameters_048x : packoffset(c048.x);
  uint _RootShaderParameters_048y : packoffset(c048.y);
};

cbuffer UniformBufferConstants_View : register(b1) {
  float UniformBufferConstants_View_136z : packoffset(c136.z);
};

SamplerState ColorSampler : register(s0);

SamplerState BloomSampler : register(s1);

SamplerState LumBilateralGridSampler : register(s2);

SamplerState BlurredLogLumSampler : register(s3);

SamplerState BloomDirtMaskSampler : register(s4);

SamplerState ColorGradingLUTSampler : register(s5);

struct OutputSignature {
  float4 SV_Target : SV_Target;
  float SV_Target_1 : SV_Target1;
};

OutputSignature main(
  noperspective float2 TEXCOORD : TEXCOORD,
  noperspective float2 TEXCOORD_1 : TEXCOORD1,
  noperspective float4 TEXCOORD_2 : TEXCOORD2,
  noperspective float2 TEXCOORD_3 : TEXCOORD3,
  noperspective float2 TEXCOORD_4 : TEXCOORD4,
  noperspective float4 SV_Position : SV_Position
) {
  float4 SV_Target;
  float3 post_lut;

  float SV_Target_1;
  // texture _1 = ColorGradingLUT;
  // texture _2 = BloomDirtMaskTexture;
  // texture _3 = BlurredLogLum;
  // texture _4 = LumBilateralGrid;
  // texture _5 = SceneColorApplyParamaters;
  // texture _6 = BloomTexture;
  // texture _7 = ColorTexture;
  // texture _8 = EyeAdaptationBuffer;
  // SamplerState _9 = ColorGradingLUTSampler;
  // SamplerState _10 = BloomDirtMaskSampler;
  // SamplerState _11 = BlurredLogLumSampler;
  // SamplerState _12 = LumBilateralGridSampler;
  // SamplerState _13 = BloomSampler;
  // SamplerState _14 = ColorSampler;
  // cbuffer _15 = UniformBufferConstants_View;
  // cbuffer _16 = _RootShaderParameters;
  // _17 = _15;
  // _18 = _16;
  float _19 = TEXCOORD_4.x;
  float _20 = TEXCOORD_4.y;
  float _21 = TEXCOORD_3.x;
  float _22 = TEXCOORD_3.y;
  float _23 = TEXCOORD_2.z;
  float _24 = TEXCOORD_2.w;
  float _25 = TEXCOORD_1.x;
  float _26 = TEXCOORD_1.y;
  float _27 = TEXCOORD.x;
  float _28 = TEXCOORD.y;
  float _30 = _RootShaderParameters_015z;
  float _31 = _RootShaderParameters_015w;
  float _32 = _RootShaderParameters_015x;
  float _33 = _RootShaderParameters_015y;
  float _34 = max(_27, _32);
  float _35 = max(_28, _33);
  float _36 = min(_34, _30);
  float _37 = min(_35, _31);
  // _38 = _7;
  // _39 = _14;
  float4 _40 = ColorTexture.Sample(ColorSampler, float2(_36, _37));
  float _41 = _40.x;
  float _42 = _40.y;
  float _43 = _40.z;
  float _45 = UniformBufferConstants_View_136z;
  float _46 = _45 * _41;
  float _47 = _45 * _42;
  float _48 = _45 * _43;
  // _49 = _8;
  float4 _50 = EyeAdaptationBuffer[0].data[0 / 4];
  float _51 = _50.x;
  float _52 = _50.w;
  float _54 = _RootShaderParameters_025w;
  float _55 = dot(float3(_46, _47, _48), float3(0.3333333432674408f, 0.3333333432674408f, 0.3333333432674408f));
  float _56 = max(_55, _54);
  float _57 = log2(_56);
  float _58 = _52 * 0.18000000715255737f;
  float _60 = _RootShaderParameters_027x;
  float _61 = _58 * _60;
  float _62 = log2(_61);
  float _64 = _RootShaderParameters_026w;
  float _65 = _RootShaderParameters_027z;
  float _66 = _RootShaderParameters_027w;
  float _67 = _65 * _19;
  float _68 = _66 * _20;
  float _69 = _RootShaderParameters_025y;
  float _70 = _69 * _57;
  float _71 = _RootShaderParameters_025z;
  float _72 = _70 + _71;
  float _73 = _72 * 0.96875f;
  float _74 = _73 + 0.015625f;
  // _75 = _4;
  // _76 = _12;
  float4 _77 = LumBilateralGrid.Sample(LumBilateralGridSampler, float3(_67, _68, _74));
  float _78 = _77.x;
  float _79 = _77.y;
  float _80 = _78 / _79;
  // _81 = _3;
  // _82 = _11;
  float4 _83 = BlurredLogLum.Sample(BlurredLogLumSampler, float2(_19, _20));
  float _84 = _83.x;
  bool _85 = (_79 < 0.0010000000474974513f);
  float _86 = _85 ? _84 : _80;
  float _87 = _84 - _86;
  float _88 = _87 * _64;
  float _89 = log2(_51);
  float _90 = _86 + _89;
  float _91 = _90 + _88;
  float _93 = _RootShaderParameters_026z;
  float _94 = _RootShaderParameters_026y;
  float _95 = _RootShaderParameters_026x;
  float _96 = _89 + _57;
  float _97 = _96 - _91;
  float _98 = _91 - _62;
  bool _99 = (_98 > 0.0f);
  float _100 = _99 ? _95 : _94;
  float _101 = _100 * _98;
  float _102 = _97 * _93;
  float _103 = _62 - _96;
  float _104 = _103 + _102;
  float _105 = _104 + _101;
  float _106 = exp2(_105);
  float _107 = _106 * _46;
  float _108 = _106 * _47;
  float _109 = _106 * _48;
  float _111 = _RootShaderParameters_041x;
  float _112 = _RootShaderParameters_041y;
  float _113 = _RootShaderParameters_041z;
  float _114 = _107 * _111;
  float _115 = _108 * _112;
  float _116 = _109 * _113;
  // _117 = _5;
  float4 _118 = SceneColorApplyParamaters[0].data[0 / 4];
  float _119 = _118.x;
  float _120 = _118.y;
  float _121 = _118.z;
  float _122 = _114 * _119;
  float _123 = _115 * _120;
  float _124 = _116 * _121;
  float _126 = _RootShaderParameters_033x;
  float _127 = _RootShaderParameters_033y;
  float _128 = _RootShaderParameters_033z;
  float _129 = _RootShaderParameters_033w;
  float _130 = _126 * _27;
  float _131 = _127 * _28;
  float _132 = _130 + _128;
  float _133 = _131 + _129;
  float _135 = _RootShaderParameters_034z;
  float _136 = _RootShaderParameters_034w;
  float _137 = _RootShaderParameters_034x;
  float _138 = _RootShaderParameters_034y;
  float _139 = max(_132, _137);
  float _140 = max(_133, _138);
  float _141 = min(_139, _135);
  float _142 = min(_140, _136);
  // _143 = _6;
  // _144 = _13;
  float4 _145 = BloomTexture.Sample(BloomSampler, float2(_141, _142));
  float _146 = _145.x;
  float _147 = _145.y;
  float _148 = _145.z;
  float _150 = UniformBufferConstants_View_136z;
  float _151 = _150 * _146;
  float _152 = _150 * _147;
  float _153 = _150 * _148;
  float _155 = _RootShaderParameters_045x;
  float _156 = _RootShaderParameters_045y;
  float _157 = _RootShaderParameters_045z;
  float _158 = _RootShaderParameters_045w;
  float _159 = _157 * _21;
  float _160 = _158 * _22;
  float _161 = _159 + _155;
  float _162 = _160 + _156;
  float _163 = _161 * 0.5f;
  float _164 = _162 * 0.5f;
  float _165 = _163 + 0.5f;
  float _166 = 0.5f - _164;
  // _167 = _2;
  // _168 = _10;
  float4 _169 = BloomDirtMaskTexture.Sample(BloomDirtMaskSampler, float2(_165, _166));
  float _170 = _169.x;
  float _171 = _169.y;
  float _172 = _169.z;
  float _174 = _RootShaderParameters_042x;
  float _175 = _RootShaderParameters_042y;
  float _176 = _RootShaderParameters_042z;
  float _177 = _174 * _170;
  float _178 = _175 * _171;
  float _179 = _176 * _172;
  float _180 = _177 + 1.0f;
  float _181 = _178 + 1.0f;
  float _182 = _179 + 1.0f;
  float _183 = _151 * _180;
  float _184 = _152 * _181;
  float _185 = _153 * _182;
  float _186 = _183 + _122;
  float _187 = _184 + _123;
  float _188 = _185 + _124;
  float _190 = _RootShaderParameters_044x;
  float _191 = _190 * _25;
  float _192 = _190 * _26;
  float _193 = dot(float2(_191, _192), float2(_191, _192));
  float _194 = _193 + 1.0f;
  float _195 = 1.0f / _194;
  float _196 = _195 * _195;
  float _197 = _51 * 0.009999999776482582f;
  float _198 = _197 * _196;
  float _199 = _198 * _186;
  float _200 = _198 * _187;
  float _201 = _198 * _188;
  float _202 = log2(_199);
  float _203 = log2(_200);
  float _204 = log2(_201);
  float _205 = _202 * 0.1593017578125f;
  float _206 = _203 * 0.1593017578125f;
  float _207 = _204 * 0.1593017578125f;
  float _208 = exp2(_205);
  float _209 = exp2(_206);
  float _210 = exp2(_207);
  float _211 = _208 * 18.8515625f;
  float _212 = _209 * 18.8515625f;
  float _213 = _210 * 18.8515625f;
  float _214 = _211 + 0.8359375f;
  float _215 = _212 + 0.8359375f;
  float _216 = _213 + 0.8359375f;
  float _217 = _208 * 18.6875f;
  float _218 = _209 * 18.6875f;
  float _219 = _210 * 18.6875f;
  float _220 = _217 + 1.0f;
  float _221 = _218 + 1.0f;
  float _222 = _219 + 1.0f;
  float _223 = 1.0f / _220;
  float _224 = 1.0f / _221;
  float _225 = 1.0f / _222;
  float _226 = _223 * _214;
  float _227 = _224 * _215;
  float _228 = _225 * _216;
  float _229 = log2(_226);
  float _230 = log2(_227);
  float _231 = log2(_228);
  float _232 = _229 * 78.84375f;
  float _233 = _230 * 78.84375f;
  float _234 = _231 * 78.84375f;
  float _235 = exp2(_232);
  float _236 = exp2(_233);
  float _237 = exp2(_234);
  float _239 = _RootShaderParameters_047z;
  float _240 = _239 * _235;
  float _241 = _239 * _236;
  float _242 = _239 * _237;
  float _243 = _RootShaderParameters_047w;
  float _244 = _240 + _243;
  float _245 = _241 + _243;
  float _246 = _242 + _243;
  // _247 = _1;
  // _248 = _9;
  float4 _249 = ColorGradingLUT.Sample(ColorGradingLUTSampler, float3(_244, _245, _246));
  post_lut = _249.rgb;

  float _250 = _249.x;
  float _251 = _249.y;
  float _252 = _249.z;
  float _253 = _250 * 1.0499999523162842f;
  float _254 = _251 * 1.0499999523162842f;
  float _255 = _252 * 1.0499999523162842f;
  float _256 = dot(float3(_253, _254, _255), float3(0.29899999499320984f, 0.5870000123977661f, 0.11400000005960464f));
  float _257 = _24 * 543.3099975585938f;
  float _258 = _257 + _23;
  float _259 = sin(_258);
  float _260 = _259 * 493013.0f;
  float _261 = frac(_260);
  float _262 = _261 * 0.00390625f;
  float _263 = _262 + -0.001953125f;
  float _264 = _263 + _253;
  float _265 = _263 + _254;
  float _266 = _263 + _255;
  uint _268 = _RootShaderParameters_048y;
  bool _269 = (_268 == 0);
  float _340 = _264;
  float _341 = _265;
  float _342 = _266;
  if (!_269) {
    float _271 = log2(_264);
    float _272 = log2(_265);
    float _273 = log2(_266);
    float _274 = _271 * 0.012683313339948654f;
    float _275 = _272 * 0.012683313339948654f;
    float _276 = _273 * 0.012683313339948654f;
    float _277 = exp2(_274);
    float _278 = exp2(_275);
    float _279 = exp2(_276);
    float _280 = _277 + -0.8359375f;
    float _281 = _278 + -0.8359375f;
    float _282 = _279 + -0.8359375f;
    float _283 = max(0.0f, _280);
    float _284 = max(0.0f, _281);
    float _285 = max(0.0f, _282);
    float _286 = _277 * 18.6875f;
    float _287 = _278 * 18.6875f;
    float _288 = _279 * 18.6875f;
    float _289 = 18.8515625f - _286;
    float _290 = 18.8515625f - _287;
    float _291 = 18.8515625f - _288;
    float _292 = _283 / _289;
    float _293 = _284 / _290;
    float _294 = _285 / _291;
    float _295 = log2(_292);
    float _296 = log2(_293);
    float _297 = log2(_294);
    float _298 = _295 * 6.277394771575928f;
    float _299 = _296 * 6.277394771575928f;
    float _300 = _297 * 6.277394771575928f;
    float _301 = exp2(_298);
    float _302 = exp2(_299);
    float _303 = exp2(_300);
    float _304 = _301 * 10000.0f;
    float _305 = _302 * 10000.0f;
    float _306 = _303 * 10000.0f;
    float _308 = _RootShaderParameters_048x;
    float _309 = _304 / _308;
    float _310 = _305 / _308;
    float _311 = _306 / _308;
    float _312 = max(6.103519990574569e-05f, _309);
    float _313 = max(6.103519990574569e-05f, _310);
    float _314 = max(6.103519990574569e-05f, _311);
    float _315 = max(_312, 0.0031306699384003878f);
    float _316 = max(_313, 0.0031306699384003878f);
    float _317 = max(_314, 0.0031306699384003878f);
    float _318 = log2(_315);
    float _319 = log2(_316);
    float _320 = log2(_317);
    float _321 = _318 * 0.4166666567325592f;
    float _322 = _319 * 0.4166666567325592f;
    float _323 = _320 * 0.4166666567325592f;
    float _324 = exp2(_321);
    float _325 = exp2(_322);
    float _326 = exp2(_323);
    float _327 = _324 * 1.0549999475479126f;
    float _328 = _325 * 1.0549999475479126f;
    float _329 = _326 * 1.0549999475479126f;
    float _330 = _327 + -0.054999999701976776f;
    float _331 = _328 + -0.054999999701976776f;
    float _332 = _329 + -0.054999999701976776f;
    float _333 = _312 * 12.920000076293945f;
    float _334 = _313 * 12.920000076293945f;
    float _335 = _314 * 12.920000076293945f;
    float _336 = min(_333, _330);
    float _337 = min(_334, _331);
    float _338 = min(_335, _332);
    _340 = _336;
    _341 = _337;
    _342 = _338;
  }
  SV_Target.x = _340;
  SV_Target.y = _341;
  SV_Target.z = _342;
  if (injectedData.toneMapType != 0.f) {
    SV_Target.rgb = post_lut;
  }
  SV_Target.w = 0.0f;
  SV_Target_1 = _256;
  OutputSignature output_signature = { SV_Target, SV_Target_1 };
  return output_signature;
}
