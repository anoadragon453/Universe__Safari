using UnityEngine;
#if UNITY_EDITOR
using UnityEngine;
#endif
using System.Collections;

public class AutoTileTexture : MonoBehaviour {
	
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		
	}
	void OnDrawGizmos()
	{
		#if UNITY_EDITOR
		this.gameObject.renderer.sharedMaterial.SetTextureScale("_MainTex",new Vector2(this.gameObject.transform.lossyScale.x,this.gameObject.transform.lossyScale.y))  ;
		#endif
	}
}