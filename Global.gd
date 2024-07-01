extends Node

const DIMENSION = Vector3(100, 8, 100)

enum {
	SOLID
}

enum {
	AIR,
	LAND
}

const types = {
	AIR:{
		SOLID:false
	},
	
	LAND:{
		SOLID:true
	}
}
