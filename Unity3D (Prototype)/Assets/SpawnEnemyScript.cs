using UnityEngine;
using System.Collections;

	public class SpawnEnemyScript : MonoBehaviour {

	public GameObject enemyPrefab;

	private int enemySpawnCounter = 0;

	public int spawnFrequency = 200;

	void Start () {

	}

	// Update is called once per frame
	void FixedUpdate () {
		if (enemySpawnCounter == spawnFrequency) {
			enemySpawnCounter = 0;
			Vector3 pos = new Vector3(7,(Random.value * 5) - 3,0);
			GameObject enemyInstance;
			enemyInstance = Instantiate(enemyPrefab, pos, Quaternion.identity) as GameObject;
		}
		enemySpawnCounter++;
	}
}
