using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace FD.Graphics {

	[ExecuteInEditMode]
	public class FDGradientAngleUI : FDGradientUI {

		public Vector2 Center = new Vector2 (0.5f, 0.5f);

		protected override void UpdateGradient () {
			base.UpdateGradient ();

			if (GradientMat != null) {

				RectTransform rect = this.transform as RectTransform;

				GradientMat.SetFloat ("_CenterX", Center.x);
				GradientMat.SetFloat ("_CenterY", Center.y);

				GradientMat.SetFloat ("_Aspect", rect.rect.width / rect.rect.height);
				GradientMat.SetInt ("_AspectMethod", 1);
			}
		}
	}
}

