class DazzlerPowerEventSequence {
	const EVENT_ARG_NA = -1; // Constant for when an event arg is not applicable

	Array<float> eventTimestampsS;
	Array<DazzlerEventType> eventTypes;
	Array<int> eventArg0Ints;

  clearscope void Init() {
		// #region Event definitions
		eventTimestampsS.Push(0);
		eventTypes.Push(HUD_1);
		eventArg0Ints.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(0.461);
		eventTypes.Push(HUD_2);
		eventArg0Ints.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(0.923);
		eventTypes.Push(HUD_3);
		eventArg0Ints.Push(EVENT_ARG_NA);

		// Double event
		eventTimestampsS.Push(1.384);
		eventTypes.Push(HUD_4);
		eventArg0Ints.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(1.384);
		eventTypes.Push(SINGLE);
		eventArg0Ints.Push(0);

		eventTimestampsS.Push(1.846);
		eventTypes.Push(SINGLE);
		eventArg0Ints.Push(1);

		eventTimestampsS.Push(1.846);
		eventTypes.Push(HUD_GO);
		eventArg0Ints.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(2.307);
		eventTypes.Push(SINGLE);
		eventArg0Ints.Push(2);

		eventTimestampsS.Push(2.769);
		eventTypes.Push(SINGLE);
		eventArg0Ints.Push(3);

		eventTimestampsS.Push(3.230);
		eventTypes.Push(SINGLE);
		eventArg0Ints.Push(4);

		// Double event	
		eventTimestampsS.Push(3.692);
		eventTypes.Push(HORIZONTAL_LINE_JUMP);
		eventArg0Ints.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(3.692);
		eventTypes.Push(HUD_JUMP);
		eventArg0Ints.Push(EVENT_ARG_NA);

		// Double event	
		eventTimestampsS.Push(4.615);
		eventTypes.Push(HORIZONTAL_LINE_CROUCH);
		eventArg0Ints.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(4.615);
		eventTypes.Push(HUD_CROUCH);
		eventArg0Ints.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(5.538);
		eventTypes.Push(VERTICAL_LINE);
		eventArg0Ints.Push(0);

		eventTimestampsS.Push(6.461);
		eventTypes.Push(VERTICAL_LINE);
		eventArg0Ints.Push(1);

		eventTimestampsS.Push(7.384);
		eventTypes.Push(VERTICAL_LINE);
		eventArg0Ints.Push(3);

		eventTimestampsS.Push(8.307);
		eventTypes.Push(VERTICAL_LINE);
		eventArg0Ints.Push(4);

		eventTimestampsS.Push(9.230);
		eventTypes.Push(VERTICAL_LINE);
		eventArg0Ints.Push(3);

		eventTimestampsS.Push(10.153);
		eventTypes.Push(VERTICAL_LINE);
		eventArg0Ints.Push(2);

		// Quadruple event
		// JK it's a double
		// eventTimestampsS.Push(11.076);
		// eventTypes.Push(VERTICAL_LINE);
		// eventArg0Ints.Push(1);

		eventTimestampsS.Push(11.076);
		eventTypes.Push(HORIZONTAL_LINE_CROUCH);
		eventArg0Ints.Push(EVENT_ARG_NA);

		// eventTimestampsS.Push(11.076);
		// eventTypes.Push(VERTICAL_LINE);
		// eventArg0Ints.Push(3);

		eventTimestampsS.Push(11.076);
		eventTypes.Push(HUD_CROUCH);
		eventArg0Ints.Push(EVENT_ARG_NA);


		// Quadruple event
		// JK it's a double
		// eventTimestampsS.Push(12.000);
		// eventTypes.Push(VERTICAL_LINE);
		// eventArg0Ints.Push(0);

		eventTimestampsS.Push(12.000);
		eventTypes.Push(HORIZONTAL_LINE_JUMP);
		eventArg0Ints.Push(EVENT_ARG_NA);

		// eventTimestampsS.Push(12.000);
		// eventTypes.Push(VERTICAL_LINE);
		// eventArg0Ints.Push(4);

		eventTimestampsS.Push(12.000);
		eventTypes.Push(HUD_JUMP);
		eventArg0Ints.Push(EVENT_ARG_NA);


		eventTimestampsS.Push(12.461);
		eventTypes.Push(SINGLE);
		eventArg0Ints.Push(2);

		eventTimestampsS.Push(12.923);
		eventTypes.Push(SINGLE);
		eventArg0Ints.Push(1);

		eventTimestampsS.Push(13.384);
		eventTypes.Push(SINGLE);
		eventArg0Ints.Push(3);

		eventTimestampsS.Push(13.846);
		eventTypes.Push(SINGLE);
		eventArg0Ints.Push(4);

		eventTimestampsS.Push(14.307);
		eventTypes.Push(SINGLE);
		eventArg0Ints.Push(0);

		// Double event
		eventTimestampsS.Push(15.230);
		eventTypes.Push(VERTICAL_LINE);
		eventArg0Ints.Push(1);

		eventTimestampsS.Push(15.230);
		eventTypes.Push(VERTICAL_LINE);
		eventArg0Ints.Push(3);

		// Triple event
		eventTimestampsS.Push(16.153);
		eventTypes.Push(VERTICAL_LINE);
		eventArg0Ints.Push(0);

		eventTimestampsS.Push(16.153);
		eventTypes.Push(VERTICAL_LINE);
		eventArg0Ints.Push(2);

		eventTimestampsS.Push(16.153);
		eventTypes.Push(VERTICAL_LINE);
		eventArg0Ints.Push(4);

		// Double event
		eventTimestampsS.Push(17.076);
		eventTypes.Push(VERTICAL_LINE);
		eventArg0Ints.Push(1);

		eventTimestampsS.Push(17.076);
		eventTypes.Push(VERTICAL_LINE);
		eventArg0Ints.Push(3);

		// Quadruple event
		eventTimestampsS.Push(18.461);
		eventTypes.Push(VERTICAL_LINE);
		eventArg0Ints.Push(1);

		eventTimestampsS.Push(18.461);
		eventTypes.Push(HORIZONTAL_LINE_CROUCH);
		eventArg0Ints.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(18.461);
		eventTypes.Push(VERTICAL_LINE);
		eventArg0Ints.Push(3);

		eventTimestampsS.Push(18.461);
		eventTypes.Push(HUD_CROUCH);
		eventArg0Ints.Push(EVENT_ARG_NA);


		// Quadruple event
		eventTimestampsS.Push(19.384);
		eventTypes.Push(VERTICAL_LINE);
		eventArg0Ints.Push(0);

		eventTimestampsS.Push(19.384);
		eventTypes.Push(HORIZONTAL_LINE_JUMP);
		eventArg0Ints.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(19.384);
		eventTypes.Push(VERTICAL_LINE);
		eventArg0Ints.Push(4);

		eventTimestampsS.Push(19.384);
		eventTypes.Push(HUD_JUMP);
		eventArg0Ints.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(20.307);
		eventTypes.Push(SINGLE);
		eventArg0Ints.Push(2);

		eventTimestampsS.Push(20.769);
		eventTypes.Push(SINGLE);
		eventArg0Ints.Push(1);

		eventTimestampsS.Push(13.384);
		eventTypes.Push(SINGLE);
		eventArg0Ints.Push(3);

		eventTimestampsS.Push(21.230);
		eventTypes.Push(SINGLE);
		eventArg0Ints.Push(4);

		eventTimestampsS.Push(21.692);
		eventTypes.Push(SINGLE);
		eventArg0Ints.Push(0);

		eventTimestampsS.Push(23.076);
		eventTypes.Push(VERTICAL_LINE);
		eventArg0Ints.Push(1);

		eventTimestampsS.Push(24.000);
		eventTypes.Push(VERTICAL_LINE);
		eventArg0Ints.Push(3);

		eventTimestampsS.Push(24.923);
		eventTypes.Push(VERTICAL_LINE);
		eventArg0Ints.Push(2);

		eventTimestampsS.Push(25.846);
		eventTypes.Push(VERTICAL_LINE);
		eventArg0Ints.Push(0);

		eventTimestampsS.Push(26.769);
		eventTypes.Push(VERTICAL_LINE);
		eventArg0Ints.Push(4);

		eventTimestampsS.Push(27.692);
		eventTypes.Push(SINGLE);
		eventArg0Ints.Push(2);

		// Double event
		eventTimestampsS.Push(28.153);
		eventTypes.Push(SINGLE);
		eventArg0Ints.Push(1);

		eventTimestampsS.Push(28.153);
		eventTypes.Push(SINGLE);
		eventArg0Ints.Push(3);

		// Double event
		eventTimestampsS.Push(28.615);
		eventTypes.Push(SINGLE);
		eventArg0Ints.Push(0);

		eventTimestampsS.Push(28.615);
		eventTypes.Push(SINGLE);
		eventArg0Ints.Push(4);

		// Line barrage
		let lineBarrageOffset = 0.1;

		eventTimestampsS.Push(29.076 + (lineBarrageOffset * 0));
		eventTypes.Push(SINGLE);
		eventArg0Ints.Push(2);

		eventTimestampsS.Push(29.076 + (lineBarrageOffset * 1));
		eventTypes.Push(SINGLE);
		eventArg0Ints.Push(2);

		eventTimestampsS.Push(29.076 + (lineBarrageOffset * 2));
		eventTypes.Push(SINGLE);
		eventArg0Ints.Push(2);

		eventTimestampsS.Push(29.076 + (lineBarrageOffset * 3));
		eventTypes.Push(SINGLE);
		eventArg0Ints.Push(2);

		eventTimestampsS.Push(29.076 + (lineBarrageOffset * 4));
		eventTypes.Push(SINGLE);
		eventArg0Ints.Push(2);

		// Line barrage
		eventTimestampsS.Push(29.538 + (lineBarrageOffset * 0));
		eventTypes.Push(SINGLE);
		eventArg0Ints.Push(1);

		eventTimestampsS.Push(29.538 + (lineBarrageOffset * 1));
		eventTypes.Push(SINGLE);
		eventArg0Ints.Push(1);

		eventTimestampsS.Push(29.538 + (lineBarrageOffset * 2));
		eventTypes.Push(SINGLE);
		eventArg0Ints.Push(1);

		eventTimestampsS.Push(29.538 + (lineBarrageOffset * 3));
		eventTypes.Push(SINGLE);
		eventArg0Ints.Push(1);

		eventTimestampsS.Push(29.538 + (lineBarrageOffset * 4));
		eventTypes.Push(SINGLE);
		eventArg0Ints.Push(1);

		// Line barrage
		eventTimestampsS.Push(30.461 + (lineBarrageOffset * 0));
		eventTypes.Push(SINGLE);
		eventArg0Ints.Push(3);

		eventTimestampsS.Push(30.461 + (lineBarrageOffset * 1));
		eventTypes.Push(SINGLE);
		eventArg0Ints.Push(3);

		eventTimestampsS.Push(30.461 + (lineBarrageOffset * 2));
		eventTypes.Push(SINGLE);
		eventArg0Ints.Push(3);

		eventTimestampsS.Push(30.461 + (lineBarrageOffset * 3));
		eventTypes.Push(SINGLE);
		eventArg0Ints.Push(3);

		eventTimestampsS.Push(30.461 + (lineBarrageOffset * 4));
		eventTypes.Push(SINGLE);
		eventArg0Ints.Push(3);

		// TODO: health shots


		// Double event	
		// JK
		eventTimestampsS.Push(33.230);
		eventTypes.Push(HORIZONTAL_LINE_JUMP);
		eventArg0Ints.Push(EVENT_ARG_NA);

		// eventTimestampsS.Push(3.692);
		// eventTypes.Push(HUD_JUMP);
		// eventArg0Ints.Push(EVENT_ARG_NA);

		// Double event	
		// JK
		eventTimestampsS.Push(34.153);
		eventTypes.Push(CIRCLE);
		eventArg0Ints.Push(EVENT_ARG_NA);

		// eventTimestampsS.Push(4.615);
		// eventTypes.Push(HUD_CROUCH);
		// eventArg0Ints.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(35.538);
		eventTypes.Push(BARRAGE_LTR);
		eventArg0Ints.Push(EVENT_ARG_NA);


		eventTimestampsS.Push(37.384);
		eventTypes.Push(BARRAGE_RTL);
		eventArg0Ints.Push(EVENT_ARG_NA);

		// End of song - marker for end of game
		eventTimestampsS.Push(eventTimestampsS[eventTimestampsS.Size() - 2] + 5.0); // 93.544; = REAL VALUE
		eventTypes.Push(NOOP);
		eventArg0Ints.Push(EVENT_ARG_NA);

		// #endregion Event definitions

		if (eventTimestampsS.Size() != eventTypes.Size() || eventTimestampsS.Size() != eventArg0Ints.Size()) {
				ThrowAbortException("event array sizes did not match. eventTimeStampS=%d eventTypes=%d eventArg0Ints=%d", eventTimestampsS.Size(), eventTypes.Size(), eventArg0Ints.Size());
		}
  }
}