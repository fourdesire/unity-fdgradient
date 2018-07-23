using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace FD.Graphics {

	[ExecuteInEditMode]
	public class FDGradient : MonoBehaviour {

		const int MAX_COLORS = 5;

		public Material GradientMat;
		public int ColorCount;
		public Color [] Colors = new Color [MAX_COLORS];
		public float [] Positions = new float [MAX_COLORS];

		protected virtual void Awake () {

			UpdateGradient ();
		}

		protected virtual void UpdateGradient () {

			if (GradientMat != null) {

				GradientMat.SetColorArray ("_GradientColors", Colors);
				GradientMat.SetFloatArray ("_GradientPosition", Positions);
				GradientMat.SetFloat ("_ColorCount", ColorCount);
			}
		}

		#if UNITY_EDITOR

		protected virtual void OnValidate () {

			UpdateGradient ();
		}

		#endif
	}
}
