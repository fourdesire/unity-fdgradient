using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace FD.Graphics {

	[ExecuteInEditMode]
	public class FDGradientAngle : FDGradient {

		public Vector2 Center = new Vector2 (0.5f, 0.5f);

		protected override void UpdateGradient () {
			base.UpdateGradient ();

			if (GradientMat != null) {

				GradientMat.SetFloat ("_CenterX", Center.x);
				GradientMat.SetFloat ("_CenterY", Center.y);
			}
		}
	}
}

