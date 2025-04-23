return {
	"sphamba/smear-cursor.nvim",

	opts = {
		-- Smear cursor when switching buffers or windows.
		smear_between_buffers = true,

		-- Smear cursor when moving within line or to neighbor lines.
		-- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
		min_horizontal_distance_smear = 12,
		min_vertical_distance_smear = 2,

		-- Draw the smear in buffer space instead of screen space when scrolling
		scroll_buffer_space = true,

		-- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
		-- Smears will blend better on all backgrounds.
		legacy_computing_symbols_support = true,
		transparent_bg_fallback_color = "#111a1f",

		-- Smear cursor in insert mode.
		-- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
		smear_insert_mode = false,

		stiffness = 1.0, -- 0.6      [0, 1]
		trailing_stiffness = 0.55, -- 0.4      [0, 1]
		stiffness_insert_mode = 0.6, -- 0.4      [0, 1]
		trailing_stiffness_insert_mode = 0.6, -- 0.4      [0, 1]
		distance_stop_animating = 0.1, -- 0.1      > 0
	},
}
