#ifndef SRC_CITIZEN_SLEEPER2_SHARED_H_
#define SRC_CITIZEN_SLEEPER2_SHARED_H_

#define RENODX_TONE_MAP_TYPE                 shader_injection.toneMapType
#define RENODX_PEAK_NITS                     shader_injection.toneMapPeakNits
#define RENODX_GAME_NITS                     shader_injection.toneMapGameNits
#define RENODX_UI_NITS                       shader_injection.toneMapUINits
#define RENODX_TONE_MAP_EXPOSURE             shader_injection.colorGradeExposure
#define RENODX_TONE_MAP_HIGHLIGHTS           shader_injection.colorGradeHighlights
#define RENODX_TONE_MAP_SHADOWS              shader_injection.colorGradeShadows
#define RENODX_TONE_MAP_CONTRAST             shader_injection.colorGradeContrast
#define RENODX_TONE_MAP_SATURATION           shader_injection.colorGradeSaturation
#define RENODX_TONE_MAP_HIGHLIGHT_SATURATION shader_injection.colorGradeHighlightSaturation
#define RENODX_TONE_MAP_BLOWOUT              shader_injection.colorGradeBlowout
#define RENODX_TONE_MAP_FLARE                shader_injection.colorGradeFlare
#define RENODX_TONE_MAP_PER_CHANNEL          1.f
#define RENODX_RENO_DRT_TONE_MAP_METHOD      renodx::tonemap::renodrt::config::tone_map_method::REINHARD
// #define RENODX_RENO_DRT_WHITE_CLIP           1.f

// Must be 32bit aligned
// Should be 4x32
struct ShaderInjectData {
  float toneMapType;
  float toneMapPeakNits;
  float toneMapGameNits;
  float toneMapUINits;

  float toneMapGammaCorrection;
  float toneMapHueShift;
  float toneMapHueCorrection;
  float toneMapHueProcessor;

  float toneMapPerChannel;
  float colorGradeExposure;
  float colorGradeHighlights;
  float colorGradeShadows;

  float colorGradeContrast;
  float colorGradeSaturation;
  float colorGradeHighlightSaturation;
  float colorGradeBlowout;

  float colorGradeFlare;
  float padding02;
  float padding03;
  float padding04;
};

#ifndef __cplusplus
#if ((__SHADER_TARGET_MAJOR == 5 && __SHADER_TARGET_MINOR >= 1) || __SHADER_TARGET_MAJOR >= 6)
cbuffer injectedBuffer : register(b13, space50) {
#elif (__SHADER_TARGET_MAJOR < 5) || ((__SHADER_TARGET_MAJOR == 5) && (__SHADER_TARGET_MINOR < 1))
cbuffer injectedBuffer : register(b13) {
#endif
  ShaderInjectData shader_injection : packoffset(c0);
}

#if (__SHADER_TARGET_MAJOR >= 6)
#pragma dxc diagnostic ignored "-Wparentheses-equality"
#endif

#include "../../shaders/renodx.hlsl"
#endif

#endif  // SRC_CITIZEN_SLEEPER2_SHARED_H_