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
 * beautyshotex.h
 *
 */

#ifndef _BEAUTY_SHOT_EX_H_
#define _BEAUTY_SHOT_EX_H_

#include "amcomdef.h"
#include "merror.h"
#include "asvloffscreen.h"

#include "abstypes.h"

class CBeautyShotEx
{
public:
	CBeautyShotEx();
	virtual ~CBeautyShotEx();

	MRESULT Init(DataType eType);
	MVoid Uninit();

	MRESULT LoadStyle(MVoid *pStyleData, MLong lDataSize);
	
	MVoid SetSkinSoftenLevel(MLong lLevel);
	MLong GetSkinSoftenLevel();
	
	MVoid SetSkinBrightLevel(MLong lLevel);
	MLong GetSkinBrightLevel();

	MVoid SetBlushInfo(TBlushInfo *pInfo);
	MRESULT GetBlushInfo(TBlushInfo *pInfo);
	
	MVoid SetSkinToneInfo(TSkinToneInfo *pInfo);
	MRESULT GetSkinToneInfo(TSkinToneInfo *pInfo);

	MVoid SetEyeEnlargmentLevel(MLong lLevel);
	MLong GetEyeEnlargmentLevel();

	MVoid SetSlenderFaceLevel(MLong lLevel);
	MLong GetSlenderFaceLevel();
	MVoid SetSkinRuddyLevel(MLong lLevel);
	MLong GetSkinRuddyLevel();

	MVoid SetDepouchLevel(MLong lLevel);
	MLong GetDepouchLevel();

	/*
	 * lFaceScale: in DataTypeVideo mode, lFaceScale can only be set to 16;
	 * 			   in DataTypeImage mode, lFaceScale can be set from 10 to 32;
	 *			   16 is the recommended value for both modes;
	 */
	MRESULT Preprocess(LPASVLOFFSCREEN pImgSrc,MLong lMaxFaceNum,MLong lFaceScale,TFaces *pInFaces, TFaces *pOutFaces);
	MRESULT Process(LPASVLOFFSCREEN pImgSrc, LPASVLOFFSCREEN pImgDst);

private:
	MVoid		*m_pEngine;
	MHandle		m_hHandle;
	DataType	m_eDataType;
};

#endif /* _BEAUTY_SHOT_EX_H_ */
