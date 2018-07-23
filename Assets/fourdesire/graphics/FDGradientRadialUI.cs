using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace FD.Graphics {

	[ExecuteInEditMode]
	public class FDGradientRadialUI : FDGradientUI {

		public Vector2 Center = new Vector2 (0.5f, 0.5f);
		public Vector2 Aspect = Vector2.one;
		public bool AutoAspect = true;

		protected override void UpdateGradient () {
			base.UpdateGradient ();

			if (GradientMat != null) {

				GradientMat.SetFloat ("_CenterX", Center.x);
				GradientMat.SetFloat ("_CenterY", Center.y);

				if (AutoAspect) {

					RectTransform rect = this.transform as RectTransform;

					if (rect.rect.width > rect.rect.height) {

						GradientMat.SetFloat ("_AspectX", 1f);
						GradientMat.SetFloat ("_AspectY", rect.rect.height / rect.rect.width);

					} else {

						GradientMat.SetFloat ("_AspectX", rect.rect.width / rect.rect.height);
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
