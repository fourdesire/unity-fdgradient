using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace FD.Graphics {

	[ExecuteInEditMode]
	public class FDGradientLinearUI : FDGradientUI {

		public float Angle = 0;

		protected override void UpdateGradient () {
			base.UpdateGradient ();

			if (GradientMat != null) {

				RectTransform rect = this.transform as RectTransform;

				if (rect.rect.width == rect.rect.height) {

					GradientMat.SetFloat ("_Angle", Angle);

				} else {

					float adjustedAngle = Mathf.Atan (Mathf.Tan (Angle * Mathf.Deg2Rad) * rect.rect.width / rect.rect.height) * Mathf.Rad2Deg;
					GradientMat.SetFloat ("_Angle", adjustedAngle);
				}
			}
		}
	}
}
