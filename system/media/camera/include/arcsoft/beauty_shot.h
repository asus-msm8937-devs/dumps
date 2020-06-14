/*----------------------------------------------------------------------------------------------
 *
 * This file is ArcSoft's property. It contains ArcSoft's trade secret, proprietary and
 * confidential information.
 *
 * The information and code contained in this file is only for authorized ArcSoft employees
 * to design, create, modify, or review.
 *
 * DO NOT DISTRIBUTE, DO NOT DUPLICATE OR TRANSMIT IN ANY FORM WITHOUT PROPER AUTHORIZATION.
 *
 * If you are not an intended recipient of this file, you must not copy, distribute, modify,
 * or take any action in reliance on it.
 *
 * If you have received this file in error, please immediately notify ArcSoft and
 * permanently delete the original and any copy of any file and any printout thereof.
 *
 *-------------------------------------------------------------------------------------------------*/
/*
 * beauty_shot.h
 *
 * Reference:
 *
 * Description:
 *
 * Create by ykzhu 2014-4-16
 *
 */

#ifndef _BEAUTY_SHOT_H_
#define _BEAUTY_SHOT_H_

#include "amcomdef.h"
#include "merror.h"
#include "asvloffscreen.h"

#include "abstypes_full.h"

//#define _DEBUG_FF

class CBeautyShot
{
public:
	CBeautyShot();
	virtual ~CBeautyShot();

	MRESULT Init(DataType eType);
	MVoid Uninit();

	MRESULT LoadStyle(MVoid *pStyleData, MLong lDataSize);
	MBool FeatureIsSupported(Feature eFeature);

	MRESULT FaceDetect(LPASVLOFFSCREEN pImgSrc, MLong lFaceScale, MLong lMaxFaceNum, MHandle *hFaceDetect);
	MRESULT FaceDetect(LPASVLOFFSCREEN pImgSrc, TFaces *pFaces, MLong lFaceScale, MLong lMaxFaceNum, MHandle *hFaceDetect);
	MRESULT GetFaces(MHandle hFaceDetect, TFaces *pFaces);

	MVoid SetSkinSoftenLevel(MLong lLevel);
	MLong GetSkinSoftenLevel();
	
	MVoid SetSkinBrightLevel(MLong lLevel);
	MLong GetSkinBrightLevel();
	
	MVoid SetSkinRuddyLevel(MLong lLevel);
	MLong GetSkinRuddyLevel();
	
	MVoid SetSuntanLevel(MLong lLevel);
	MVoid SetSuntanColor(MCOLORREF clr);
	MLong GetSuntanLevel();
	MCOLORREF GetSuntanColor();

	MVoid SetBlushInfo(TBlushInfo *pInfo);
	MRESULT GetBlushInfo(TBlushInfo *pInfo);

	MVoid SetSkinToneInfo(TSkinToneInfo *pInfo);
	MRESULT GetSkinToneInfo(TSkinToneInfo *pInfo);
	
	MVoid SetEyeEnlargmentLevel(MLong lLevel);
	MLong GetEyeEnlargmentLevel();

	MVoid SetEyeColorLevel(MLong lLevel);
	MVoid SetEyeColorColor(MCOLORREF clr);
	MLong GetEyeColorLevel();
	MCOLORREF GetEyeColorColor();

	MVoid SetEyeShadowInfo(TEyeShadowInfo *pInfo);
	MRESULT GetEyeShadowInfo(TEyeShadowInfo *pInfo);

	MVoid SetEyeLinerLevel(MLong lLevel);
	MVoid SetEyeLinerColor(MCOLORREF clr);
	MLong GetEyeLinerLevel();
	MCOLORREF GetEyeLinerColor();

	MVoid SetEyeLashLevel(MLong lLevel);
	MVoid SetEyeLashColor(MCOLORREF clr);
	MLong GetEyeLashLevel();
	MCOLORREF GetEyeLashColor();

	MVoid SetCatchLightLevel(MLong lLevel);
	MLong GetCatchLightLevel();

	MVoid SetLipstickLevel(MLong lLevel);
	MVoid SetLipstickColor(MCOLORREF clr);
	MLong GetLipstickLevel();
	MCOLORREF GetLipstickColor();

	MVoid SetSlenderFaceLevel(MLong lLevel);
	MLong GetSlenderFaceLevel();

	MVoid SetNoseHighlightLevel(MLong lLevel);
	MLong GetNoseHighlightLevel();

	MVoid SetShapeStrengthLevel(MLong lLevel);
	MLong GetShapeStrengthLevel();
	MVoid SetAutoSkinToneBrightLevel(MLong lLevel);
	MLong GetAutoSkinToneBrightLevel();

	MVoid SetDepouchLevel(MLong lLevel);
	MLong GetDepouchLevel();

	MRESULT EnableMultiThread(MBool bMultiThread);

	MRESULT Process(MHandle hFaceDetect, LPASVLOFFSCREEN pImgSrc, LPASVLOFFSCREEN pImgDst, MLong lFaceNo);

private:
	MRESULT InitEngine();
	MVoid UninitEngine();

private:
	MBool		m_bInit;
	DataType	m_eDataType;
	MDWord		m_dwModel;
	MHandle		m_hFFEngine;
	MVoid		*m_pParameters;
	MVoid		*m_pPreRes;

	MHandle		m_hMemMgr;
	MVoid*		m_pMem;
};


#ifdef ENABLE_DLL_EXPORT
#define ABS_API __declspec(dllexport)
#else
#define ABS_API
#endif


#ifdef __cplusplus
extern "C" {
#endif


/************************************************************************
 * The function used to get version information of Beauty Shot library.
 ************************************************************************/
typedef struct{
	MLong			lCodebase;             	// Codebase version number
	MLong			lMajor;                	// major version number
	MLong			lMinor;                	// minor version number
	MLong			lBuild;                	// Build version number, increasable only
	const MChar*	Version;		      	// version in string form
	const MChar*	BuildDate;			// latest build Date
	const MChar*	CopyRight;      		// copyright
} ABEAUTYSHOT_Version;
ABS_API const ABEAUTYSHOT_Version* ABEAUTYSHOT_GetIntegrateVersion();

#ifdef __cplusplus
}
#endif

#endif /* _BEAUTY_SHOT_H_ */
