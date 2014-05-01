using UnityEngine;
using System.Collections;

public class ScrollingBackgroundScript : MonoBehaviour {
	public Transform myCamera;
	public float cameraSpeed = 1.0f;
	public float backgroundSpeed = 1.0f;
	
	void FixedUpdate() {
		Vector2 aux = renderer.material.mainTextureOffset;
		aux += new Vector2(backgroundSpeed*cameraSpeed*Time.deltaTime,0);
		renderer.material.mainTextureOffset = aux;
		
		Vector3 aux2 = new Vector3(transform.position.x,transform.position.y,transform.position.z);
		transform.position = aux2;
	}
}