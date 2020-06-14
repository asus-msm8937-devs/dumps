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
 * abstypes.h
 *
 * Reference:
 *
 * Description:
 *
 * Create by ykzhu 2014-7-9
 *
 */

#ifndef _ABS_TYPES_H_
#define _ABS_TYPES_H_

#include "amcomdef.h"

#define MAX_FACE_NUM 32
typedef struct _tagFaces {
	MRECT		prtFaces[MAX_FACE_NUM];			// The bounding box of face
	MLong		lFaceNum;						// Number of faces detected
	MLong		plFaceRolls[MAX_FACE_NUM];		// The angle of each face, between [0, 360)
	MLong		plFaceScore[MAX_FACE_NUM];		// Similarity score of each face
} TFaces;

#define MAX_COLOR_NUM 4
typedef struct _tagBlushInfo {
	MCOLORREF	pColors[MAX_COLOR_NUM];
	MLong		lColorNum;
	MLong		lLevel;
} TBlushInfo;

typedef struct _tagSkinToneInfo {
	MLong		lBrightLevel;
	MLong		lColorLevel;
	MCOLORREF	crSkinTone;
} TSkinToneInfo;

enum DataType {DataTypeVideo = 0, DataTypeImage = 1, DataTypeVideoRecord = 2};

#endif /* _ABS_TYPES_H_ */
