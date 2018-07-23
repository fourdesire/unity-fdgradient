using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace FD.Graphics {

	[ExecuteInEditMode]
	public class FDGradientRadial : FDGradient {

		public Vector2 Center = new Vector2 (0.5f, 0.5f);
		public Vector2 Aspect = Vector2.one;
		public bool AutoAspect = true;

		protected override void UpdateGradient () {
			base.UpdateGradient ();

			if (GradientMat != null) {

				GradientMat.SetFloat ("_CenterX", Center.x);
				GradientMat.SetFloat ("_CenterY", Center.y);

				if (AutoAspect) {

					if (this.transform.localScale.x > this.transform.localScale.y) {

						GradientMat.SetFloat ("_AspectX", 1f);
						GradientMat.SetFloat ("_AspectY", this.transform.localScale.y / this.transform.localScale.x);

					} else {

						GradientMat.SetFloat ("_AspectX", this.transform.localScale.x / this.transform.localScale.y);
						GradientMat.SetFloat ("_AspectY", 1f);
					}

				} else {

					GradientMat.SetFloat ("_AspectX", Aspect.x);
					GradientMat.SetFloat ("_AspectY", Aspect.y);
				}
			}
		}
	}
}
