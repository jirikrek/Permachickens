extends WATTest

func test_minute_signal():
	watch(GameOClock, "minute_tick")
	GameOClock._process(10.0)
	asserts.signal_was_emitted(GameOClock, "minute_tick")
