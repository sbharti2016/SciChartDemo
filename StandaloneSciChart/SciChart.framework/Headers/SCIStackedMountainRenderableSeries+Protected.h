//******************************************************************************
// SCICHART® Copyright SciChart Ltd. 2011-2019. All rights reserved.
//
// Web: http://www.scichart.com
// Support: support@scichart.com
// Sales:   sales@scichart.com
//
// SCIStackedMountainRenderableSeries+Protected.h is part of SCICHART®, High Performance Scientific Charts
// For full terms and conditions of the license, see http://www.scichart.com/scichart-eula/
//
// This source code is protected by international copyright law. Unauthorized
// reproduction, reverse-engineering, or distribution of all or any portion of
// this source code is strictly prohibited.
//
// This source code contains confidential and proprietary trade secrets of
// SciChart Ltd., and should at no time be copied, transferred, sold,
// distributed or made available without express written permission.
//******************************************************************************

#import "SCIBaseMountainRenderableSeries+Protected.h"
#import "SCIStackedMountainRenderPassData.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * The extensions in this header are to be used only by subclasses of `SCIFastMountainRenderableSeries`.
 */
@interface SCIStackedMountainRenderableSeries  ()

@property (strong, nonatomic) SCISmartPropertyBool *isDigitalLineProperty;

@end

/**
 * The extensions in this header are to be used only by subclasses of `SCIStackedMountainRenderableSeries`.
 */
@interface SCIStackedMountainRenderableSeries (Protected)

/**
 * Creates a new instance of `SCIStackedMountainRenderableSeries` class.
 * @param renderPassData The render pass data instance.
 * @param hitProvider The hit provider instance.
 * @param nearestPointProvider The nearest point provider instance.
 */
- (instancetype)initWithRenderPassData:(SCIStackedMountainRenderPassData *)renderPassData hitProvider:(id<ISCIHitProvider>)hitProvider nearestPointProvider:(id<ISCINearestPointProvider>)nearestPointProvider;

@end

NS_ASSUME_NONNULL_END
