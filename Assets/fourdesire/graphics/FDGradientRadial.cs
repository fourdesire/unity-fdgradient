using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace FD.Graphics {

	[ExecuteInEditMode]
	public class FDGradientRadial : FDGradient {

		public Vector2 Center = new Vector2 (0.5f, 0.5f);
		public Vector2 Aspect = Vector2.one;

		protected override void UpdateGradient () {
			base.UpdateGradient ();

			if (GradientMat != null) {

				GradientMat.SetFloat ("_CenterX", Center.x);
				GradientMat.SetFloat ("_CenterY", Center.y);
				GradientMat.SetFloat ("_AspectX", Aspect.x);
				GradientMat.SetFloat ("_AspectY", Aspect.y);
			}
		}
	}
}
