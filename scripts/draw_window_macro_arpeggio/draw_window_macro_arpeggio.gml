function draw_window_macro_arpeggio() {
	// draw_window_macro_arpeggio()
	var x1, y1, a, i, pattern, str, total_vals, val, arplen
	if (theme = 3) draw_set_alpha(windowalpha)
	curs = cr_default
	text_exists[0] = 0
	if (selected = 0) return 0
	x1 = floor(rw / 2 - 80)
	y1 = floor(rh / 2 - 80)
	draw_window(x1, y1, x1 + 140, y1 + 130)
	draw_set_font(fnt_mainbold)
		if (theme = 3) draw_set_font(fnt_wslui_bold)
	draw_text(x1 + 8, y1 + 8, "Arpeggio")
	pattern = ""
	draw_set_font(fnt_main)
		if (theme = 3) draw_set_font(fnt_wslui)
	if (theme = 0) {
	    draw_set_color(c_white)
	    draw_rectangle(x1 + 6, y1 + 26, x1 + 134, y1 + 92, 0)
	    draw_set_color(make_color_rgb(137, 140, 149))
	    draw_rectangle(x1 + 6, y1 + 26, x1 + 134, y1 + 92, 1)
	}
	draw_areaheader(x1 + 10, y1 + 43, 120, 35, "Pattern")

	pattern = draw_textarea(57, x1 + 15, y1 + 50, 113, 25, string(pattern), "Must separate relative keys with pipes.") 

	draw_theme_color()
	if (draw_button2(x1 + 10, y1 + 98, 60, "OK")) {
	if string_count("|", pattern) = 0 {
		message("Please add pipes ( | ) to separate values!", "Error")
		return 1
	}
	window = 0
	str = selection_code
	arr_data = selection_to_array(str)
	total_vals = string_count("|", str)
	val = 0
	pattern = string_digits_symbol(pattern, "|")
	pattern = string(pattern + "|")
	arp = selection_to_array(pattern)
	arplen = string_count("|", pattern)
		while (val < total_vals) {
			for (i = 0; i < arplen; i++;) {
				val += 3
				if (arr_data[val] + arp[i] > 0 || arr_data[val] + arp[i] < 88) {
					arr_data[val] = real(arr_data[val]) + real(arp[i])
				}
				val += 4
				while arr_data[val] != -1 {
					val += 2
					if (arr_data[val] + arp[i] > 0 || arr_data[val] + arp[i] < 88) {
						arr_data[val] = real(arr_data[val]) + real(arp[i])
					}
					val += 4
				}
			val ++
			if val >= total_vals break
			}
		if val >= total_vals break
		}
		str = array_to_selection(arr_data, total_vals)
		selection_load(selection_x,selection_y,str,true)
		selection_code_update()
	}
	if (draw_button2(x1 + 70, y1 + 98, 60, "Cancel")) {windowclose = 1}
	window_set_cursor(curs)
	window_set_cursor(cr_default)
	if (windowopen = 0 && theme = 3) {
		if (windowalpha < 1) {
			if (refreshrate = 0) windowalpha += 1/3.75
			else if (refreshrate = 1) windowalpha += 1/7.5
			else if (refreshrate = 2) windowalpha += 1/15
			else if (refreshrate = 3) windowalpha += 1/18
			else windowalpha += 1/20
		} else {
			windowalpha = 1
			windowopen = 1
		}
	}
	if(theme = 3) {
		if (windowclose = 1) {
			if (windowalpha > 0) {
				if (refreshrate = 0) windowalpha -= 1/3.75
				else if (refreshrate = 1) windowalpha -= 1/7.5
				else if (refreshrate = 2) windowalpha -= 1/15
				else if (refreshrate = 3) windowalpha -= 1/18
				else windowalpha -= 1/20
			} else {
				windowalpha = 0
				windowclose = 0
				windowopen = 0
				window = 0
				window_set_cursor(curs)
				save_settings()
			}
		}
	} else {
		if (windowclose = 1) {
			windowclose = 0
			window = 0
		}
	}
	draw_set_alpha(1)

}
