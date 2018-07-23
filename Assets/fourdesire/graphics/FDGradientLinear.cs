using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace FD.Graphics {

	[ExecuteInEditMode]
	public class FDGradientLinear : FDGradient {

		public float Angle = 0;

		protected override void UpdateGradient () {
			base.UpdateGradient ();

			if (GradientMat != null) {

				if (this.transform.localScale.x == this.transform.localScale.y) {

					GradientMat.SetFloat ("_Angle", Angle);

				} else {

					float adjustedAngle = Mathf.Atan (Mathf.Tan (Angle * Mathf.Deg2Rad) * this.transform.localScale.x / this.transform.localScale.y) * Mathf.Rad2Deg;
					GradientMat.SetFloat ("_Angle", adjustedAngle);
				}
			}
		}
	}
}
