extends TextureRect


var rectSize: Vector2;
var rows: int;
var columns: int;
var fg := Color.GRAY;

func _init() -> void:
	var viewport = get_viewport_rect().size;
	rectSize = viewport;
	rows = viewport.x / Globals.tileSize;
	columns = viewport.y/ Globals.tileSize;

func _draw() -> void:
	print("drawing");
	var w = rectSize.x;
	var h = rectSize.y;
	var cw = w/columns; #cell width
	var ch = h/rows; #cell height
	for row in range(1,rows, 2):
		var y = ch*row+(ch*0.5);
		draw_line( Vector2(0,y), Vector2(w,y), fg, ch );

	for column in range(1,columns, 2):
		var x = cw*column+(cw*0.5);
		draw_line( Vector2(x,0), Vector2(x,h), fg, cw );

func _process(delta: float) -> void:
	_draw();
