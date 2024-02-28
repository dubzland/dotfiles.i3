PIANOBAR_STATE="${PIANOBAR_STATE:-${XDG_STATE_HOME:-$HOME/.local/state}/pianobar}"

PIANOBAR_SOCKET="${PIANOBAR_STATE}/socket"

function send_notification() {
	notify-send --hint=int:transient:1 "$@"
}

function is_running() {
	if [[ -n $(pidof pianobar) ]]; then
		return 0
	else
		return 1
	fi
}

now_playing="${PIANOBAR_STATE}/now_playing"
function get_now_playing() {
	cat "$now_playing"
}
function set_now_playing() {
	local artist="$1"
	local song="$2"

	printf "$artist - $song" > "$now_playing"
}

is_playing="${PIANOBAR_STATE}/is_playing"
function get_is_playing() {
	cat "$is_playing"
}
function set_is_playing() {
	printf "$1" > "$is_playing"
}

stationlist="${PIANOBAR_STATE}/stationlist"
function clear_stationlist() {
	rm -f "${stationlist}"
}
function add_station() {
	printf "$1) $2\n" >> "${stationlist}"
}
