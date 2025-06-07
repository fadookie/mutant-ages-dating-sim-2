class DazzlerPowerEventSequence {
	const EVENT_ARG_NA = -1; // Constant for when an event arg is not applicable
	const JUMP_HEIGHT = 8.0;
	const CROUCH_HEIGHT = 32.0;

	Array<float> eventTimestampsS;
	Array<DazzlerEventType> eventTypes;
	Array<DazzlerShotType> eventShotTypes;
	// An event can have multiple "arg 0" arguments if they are different types
	Array<int> eventArg0Ints; // Currenlty used for spawn origin map spot index
	Array<int> eventArg0Floats; // Currently used for spawn z-height

  clearscope void Init() {
		// #region Event definitions
		eventTimestampsS.Push(0);
		eventTypes.Push(HUD_1);
		eventShotTypes.Push(SHOT_NONE);
		eventArg0Ints.Push(EVENT_ARG_NA);
		eventArg0Floats.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(0.461);
		eventTypes.Push(HUD_2);
		eventShotTypes.Push(SHOT_NONE);
		eventArg0Ints.Push(EVENT_ARG_NA);
		eventArg0Floats.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(0.923);
		eventTypes.Push(HUD_3);
		eventShotTypes.Push(SHOT_NONE);
		eventArg0Ints.Push(EVENT_ARG_NA);
		eventArg0Floats.Push(EVENT_ARG_NA);

		// Double event
		eventTimestampsS.Push(1.384);
		eventTypes.Push(HUD_4);
		eventShotTypes.Push(SHOT_NONE);
		eventArg0Ints.Push(EVENT_ARG_NA);
		eventArg0Floats.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(1.384);
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(0);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		eventTimestampsS.Push(1.846);
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(1);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		eventTimestampsS.Push(1.846);
		eventTypes.Push(HUD_GO);
		eventShotTypes.Push(SHOT_NONE);
		eventArg0Ints.Push(EVENT_ARG_NA);
		eventArg0Floats.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(2.307);
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL); // Was DAZZLER_HEALTH for testing
		eventArg0Ints.Push(2);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		eventTimestampsS.Push(2.769);
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(3);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		eventTimestampsS.Push(3.230);
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(4);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		// Temp END
		// eventTimestampsS.Push(3.692);
		// eventTypes.Push(END);
		// eventArg0Ints.Push(EVENT_ARG_NA);
		// eventArg0Floats.Push(EVENT_ARG_NA);

		// Double event	
		eventTimestampsS.Push(3.692);
		eventTypes.Push(HORIZONTAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(EVENT_ARG_NA);
		eventArg0Floats.Push(JUMP_HEIGHT);

		eventTimestampsS.Push(3.692);
		eventTypes.Push(HUD_JUMP);
		eventShotTypes.Push(SHOT_NONE);
		eventArg0Ints.Push(EVENT_ARG_NA);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		// Double event	
		eventTimestampsS.Push(4.615);
		eventTypes.Push(HORIZONTAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(EVENT_ARG_NA);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		eventTimestampsS.Push(4.615);
		eventTypes.Push(HUD_CROUCH);
		eventShotTypes.Push(SHOT_NONE);
		eventArg0Ints.Push(EVENT_ARG_NA);
		eventArg0Floats.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(5.538);
		eventTypes.Push(VERTICAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(0);
		eventArg0Floats.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(6.461);
		eventTypes.Push(VERTICAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(1);
		eventArg0Floats.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(7.384);
		eventTypes.Push(VERTICAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(3);
		eventArg0Floats.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(8.307);
		eventTypes.Push(VERTICAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(4);
		eventArg0Floats.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(9.230);
		eventTypes.Push(VERTICAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(3);
		eventArg0Floats.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(10.153);
		eventTypes.Push(VERTICAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(2);
		eventArg0Floats.Push(EVENT_ARG_NA);

		// Quadruple event
		// JK it's a double
		// eventTimestampsS.Push(11.076);
		// eventTypes.Push(VERTICAL_LINE);
		// eventArg0Ints.Push(1);

		eventTimestampsS.Push(11.076);
		eventTypes.Push(HORIZONTAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(EVENT_ARG_NA);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		// eventTimestampsS.Push(11.076);
		// eventTypes.Push(VERTICAL_LINE);
		// eventArg0Ints.Push(3);

		eventTimestampsS.Push(11.076);
		eventTypes.Push(HUD_CROUCH);
		eventShotTypes.Push(SHOT_NONE);
		eventArg0Ints.Push(EVENT_ARG_NA);
		eventArg0Floats.Push(EVENT_ARG_NA);


		// Quadruple event
		// JK it's a double
		// eventTimestampsS.Push(12.000);
		// eventTypes.Push(VERTICAL_LINE);
		// eventArg0Ints.Push(0);

		eventTimestampsS.Push(12.000);
		eventTypes.Push(HORIZONTAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(EVENT_ARG_NA);
		eventArg0Floats.Push(JUMP_HEIGHT);

		// eventTimestampsS.Push(12.000);
		// eventTypes.Push(VERTICAL_LINE);
		// eventArg0Ints.Push(4);

		eventTimestampsS.Push(12.000);
		eventTypes.Push(HUD_JUMP);
		eventShotTypes.Push(SHOT_NONE);
		eventArg0Ints.Push(EVENT_ARG_NA);
		eventArg0Floats.Push(EVENT_ARG_NA);


		eventTimestampsS.Push(12.461);
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(2);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		eventTimestampsS.Push(12.923);
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(1);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		eventTimestampsS.Push(13.384);
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(3);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		eventTimestampsS.Push(13.846);
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(4);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		eventTimestampsS.Push(14.307);
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(0);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		// Double event
		eventTimestampsS.Push(15.230);
		eventTypes.Push(VERTICAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(1);
		eventArg0Floats.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(15.230);
		eventTypes.Push(VERTICAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(3);
		eventArg0Floats.Push(EVENT_ARG_NA);

		// Triple event
		eventTimestampsS.Push(16.153);
		eventTypes.Push(VERTICAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(0);
		eventArg0Floats.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(16.153);
		eventTypes.Push(VERTICAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(2);
		eventArg0Floats.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(16.153);
		eventTypes.Push(VERTICAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(4);
		eventArg0Floats.Push(EVENT_ARG_NA);

		// Double event
		eventTimestampsS.Push(17.076);
		eventTypes.Push(VERTICAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(1);
		eventArg0Floats.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(17.076);
		eventTypes.Push(VERTICAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(3);
		eventArg0Floats.Push(EVENT_ARG_NA);

		// Quadruple event
		eventTimestampsS.Push(18.461);
		eventTypes.Push(VERTICAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(1);
		eventArg0Floats.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(18.461);
		eventTypes.Push(HORIZONTAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(EVENT_ARG_NA);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		eventTimestampsS.Push(18.461);
		eventTypes.Push(VERTICAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(3);
		eventArg0Floats.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(18.461);
		eventTypes.Push(HUD_CROUCH);
		eventShotTypes.Push(SHOT_NONE);
		eventArg0Ints.Push(EVENT_ARG_NA);
		eventArg0Floats.Push(EVENT_ARG_NA);


		// Quadruple event
		eventTimestampsS.Push(19.384);
		eventTypes.Push(VERTICAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(0);
		eventArg0Floats.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(19.384);
		eventTypes.Push(HORIZONTAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(EVENT_ARG_NA);
		eventArg0Floats.Push(JUMP_HEIGHT);

		eventTimestampsS.Push(19.384);
		eventTypes.Push(VERTICAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(4);
		eventArg0Floats.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(19.384);
		eventTypes.Push(HUD_JUMP);
		eventShotTypes.Push(SHOT_NONE);
		eventArg0Ints.Push(EVENT_ARG_NA);
		eventArg0Floats.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(20.307);
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(2);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		eventTimestampsS.Push(20.769);
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(1);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		eventTimestampsS.Push(13.384);
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(3);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		eventTimestampsS.Push(21.230);
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(4);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		eventTimestampsS.Push(21.692);
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(0);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		eventTimestampsS.Push(23.076);
		eventTypes.Push(VERTICAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(1);
		eventArg0Floats.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(24.000);
		eventTypes.Push(VERTICAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(3);
		eventArg0Floats.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(24.923);
		eventTypes.Push(VERTICAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(2);
		eventArg0Floats.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(25.846);
		eventTypes.Push(VERTICAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(0);
		eventArg0Floats.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(26.769);
		eventTypes.Push(VERTICAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(4);
		eventArg0Floats.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(27.692);
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(2);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		// Double event
		eventTimestampsS.Push(28.153);
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(1);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		eventTimestampsS.Push(28.153);
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(3);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		// Double event
		eventTimestampsS.Push(28.615);
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(0);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		eventTimestampsS.Push(28.615);
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(4);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		// Line barrage
		let lineBarrageOffset = 0.1;

		eventTimestampsS.Push(29.076 + (lineBarrageOffset * 0));
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(2);
		eventArg0Floats.Push(JUMP_HEIGHT);

		eventTimestampsS.Push(29.076 + (lineBarrageOffset * 1));
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(2);
		eventArg0Floats.Push(JUMP_HEIGHT);

		eventTimestampsS.Push(29.076 + (lineBarrageOffset * 2));
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(2);
		eventArg0Floats.Push(JUMP_HEIGHT);

		eventTimestampsS.Push(29.076 + (lineBarrageOffset * 3));
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(2);
		eventArg0Floats.Push(JUMP_HEIGHT);

		eventTimestampsS.Push(29.076 + (lineBarrageOffset * 4));
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(2);
		eventArg0Floats.Push(JUMP_HEIGHT);

		// Line barrage
		eventTimestampsS.Push(29.538 + (lineBarrageOffset * 0));
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(1);
		eventArg0Floats.Push(JUMP_HEIGHT);

		eventTimestampsS.Push(29.538 + (lineBarrageOffset * 1));
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(1);
		eventArg0Floats.Push(JUMP_HEIGHT);

		eventTimestampsS.Push(29.538 + (lineBarrageOffset * 2));
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(1);
		eventArg0Floats.Push(JUMP_HEIGHT);

		eventTimestampsS.Push(29.538 + (lineBarrageOffset * 3));
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(1);
		eventArg0Floats.Push(JUMP_HEIGHT);

		eventTimestampsS.Push(29.538 + (lineBarrageOffset * 4));
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(1);
		eventArg0Floats.Push(JUMP_HEIGHT);

		// Line barrage
		eventTimestampsS.Push(30.461 + (lineBarrageOffset * 0));
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(3);
		eventArg0Floats.Push(JUMP_HEIGHT);

		eventTimestampsS.Push(30.461 + (lineBarrageOffset * 1));
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(3);
		eventArg0Floats.Push(JUMP_HEIGHT);

		eventTimestampsS.Push(30.461 + (lineBarrageOffset * 2));
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(3);
		eventArg0Floats.Push(JUMP_HEIGHT);

		eventTimestampsS.Push(30.461 + (lineBarrageOffset * 3));
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(3);
		eventArg0Floats.Push(JUMP_HEIGHT);

		eventTimestampsS.Push(30.461 + (lineBarrageOffset * 4));
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(3);
		eventArg0Floats.Push(JUMP_HEIGHT);

		eventTimestampsS.Push(19.384);
		eventTypes.Push(VERTICAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(0);
		eventArg0Floats.Push(EVENT_ARG_NA);

		// TODO: health shots


		// Double event	
		// JK
		eventTimestampsS.Push(33.230);
		eventTypes.Push(HORIZONTAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(EVENT_ARG_NA);
		eventArg0Floats.Push(JUMP_HEIGHT);

		// eventTimestampsS.Push(3.692);
		// eventTypes.Push(HUD_JUMP);
		// eventArg0Ints.Push(EVENT_ARG_NA);

		// Double event	
		// JK
		eventTimestampsS.Push(34.153);
		eventTypes.Push(CIRCLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(EVENT_ARG_NA);
		eventArg0Floats.Push(EVENT_ARG_NA);

		// eventTimestampsS.Push(4.615);
		// eventTypes.Push(HUD_CROUCH);
		// eventArg0Ints.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(35.538);
		eventTypes.Push(BARRAGE_LTR);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(EVENT_ARG_NA);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		eventTimestampsS.Push(37.384);
		eventTypes.Push(BARRAGE_RTL);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(EVENT_ARG_NA);
		eventArg0Floats.Push(JUMP_HEIGHT);

		eventTimestampsS.Push(39.231);
		eventTypes.Push(CIRCLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(EVENT_ARG_NA);
		eventArg0Floats.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(40.615);
		eventTypes.Push(HORIZONTAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(EVENT_ARG_NA);
		eventArg0Floats.Push(JUMP_HEIGHT);

		eventTimestampsS.Push(42.462);
		eventTypes.Push(BARRAGE_RTL);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(EVENT_ARG_NA);
		eventArg0Floats.Push(JUMP_HEIGHT);

		eventTimestampsS.Push(44.308);
		eventTypes.Push(HORIZONTAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(EVENT_ARG_NA);
		eventArg0Floats.Push(JUMP_HEIGHT);

		eventTimestampsS.Push(45.692);
		eventTypes.Push(BARRAGE_LTR);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(EVENT_ARG_NA);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		eventTimestampsS.Push(48.000);
		eventTypes.Push(HORIZONTAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(EVENT_ARG_NA);
		eventArg0Floats.Push(JUMP_HEIGHT);

		// Line barrage
		eventTimestampsS.Push(49.846 + (lineBarrageOffset * 0));
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(3);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		eventTimestampsS.Push(49.846 + (lineBarrageOffset * 1));
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(3);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		eventTimestampsS.Push(49.846 + (lineBarrageOffset * 2));
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(3);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		eventTimestampsS.Push(49.846 + (lineBarrageOffset * 3));
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(3);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		eventTimestampsS.Push(49.846 + (lineBarrageOffset * 4));
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(3);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		// Line barrage
		eventTimestampsS.Push(50.769 + (lineBarrageOffset * 0));
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(1);
		eventArg0Floats.Push(JUMP_HEIGHT);

		eventTimestampsS.Push(50.769 + (lineBarrageOffset * 1));
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(1);
		eventArg0Floats.Push(JUMP_HEIGHT);

		eventTimestampsS.Push(50.769 + (lineBarrageOffset * 2));
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(1);
		eventArg0Floats.Push(JUMP_HEIGHT);

		eventTimestampsS.Push(50.769 + (lineBarrageOffset * 3));
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(1);
		eventArg0Floats.Push(JUMP_HEIGHT);

		eventTimestampsS.Push(50.769 + (lineBarrageOffset * 4));
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(1);
		eventArg0Floats.Push(JUMP_HEIGHT);

		// Line barrage
		eventTimestampsS.Push(51.692 + (lineBarrageOffset * 0));
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(2);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		eventTimestampsS.Push(51.692 + (lineBarrageOffset * 1));
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(2);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		eventTimestampsS.Push(51.692 + (lineBarrageOffset * 2));
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(2);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		eventTimestampsS.Push(51.692 + (lineBarrageOffset * 3));
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(2);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		eventTimestampsS.Push(51.692 + (lineBarrageOffset * 4));
		eventTypes.Push(SINGLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(2);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		// Double event
		eventTimestampsS.Push(53.077);
		eventTypes.Push(VERTICAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(0);
		eventArg0Floats.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(53.077);
		eventTypes.Push(VERTICAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(4);
		eventArg0Floats.Push(EVENT_ARG_NA);

		// Double event
		eventTimestampsS.Push(54.000);
		eventTypes.Push(VERTICAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(1);
		eventArg0Floats.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(54.000);
		eventTypes.Push(VERTICAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(3);
		eventArg0Floats.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(54.923);
		eventTypes.Push(HORIZONTAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(EVENT_ARG_NA);
		eventArg0Floats.Push(JUMP_HEIGHT);

		// Triple event
		eventTimestampsS.Push(56.308);
		eventTypes.Push(VERTICAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(1);
		eventArg0Floats.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(56.308);
		eventTypes.Push(HORIZONTAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(EVENT_ARG_NA);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		eventTimestampsS.Push(56.308);
		eventTypes.Push(VERTICAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(3);
		eventArg0Floats.Push(EVENT_ARG_NA);

		// BEGIN FINAL BASS SEQUENCE
		eventTimestampsS.Push(57.692);
		eventTypes.Push(HORIZONTAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(EVENT_ARG_NA);
		eventArg0Floats.Push(JUMP_HEIGHT);

		eventTimestampsS.Push(59.077);
		eventTypes.Push(HORIZONTAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(EVENT_ARG_NA);
		eventArg0Floats.Push(JUMP_HEIGHT);

		eventTimestampsS.Push(60.462);
		eventTypes.Push(HORIZONTAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(EVENT_ARG_NA);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		// BEGIN last bar. Quadruple Event
		eventTimestampsS.Push(61.385);
		eventTypes.Push(CIRCLE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(EVENT_ARG_NA);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		eventTimestampsS.Push(61.385);
		eventTypes.Push(VERTICAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(0);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		eventTimestampsS.Push(61.385);
		eventTypes.Push(VERTICAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(4);
		eventArg0Floats.Push(CROUCH_HEIGHT);

		eventTimestampsS.Push(61.385);
		eventTypes.Push(HORIZONTAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(EVENT_ARG_NA);
		eventArg0Floats.Push(16.0 * 6);


		// BEGIN final arpeggio
		// Double event
		// JK
		// eventTimestampsS.Push(63.068);
		// eventTypes.Push(SINGLE);
		// eventShotTypes.Push(DAZZLER_BALL);
		// eventArg0Ints.Push(1);
		// eventArg0Floats.Push(CROUCH_HEIGHT);

		// eventTimestampsS.Push(63.068);
		// eventTypes.Push(SINGLE);
		// eventShotTypes.Push(DAZZLER_BALL);
		// eventArg0Ints.Push(1);
		// eventArg0Floats.Push(JUMP_HEIGHT);

		eventTimestampsS.Push(63.068);
		eventTypes.Push(VERTICAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(1);
		eventArg0Floats.Push(EVENT_ARG_NA);

		// Double event
		// JK
		// eventTimestampsS.Push(63.068);
		// eventTypes.Push(SINGLE);
		// eventShotTypes.Push(DAZZLER_BALL);
		// eventArg0Ints.Push(2);
		// eventArg0Floats.Push(CROUCH_HEIGHT);

		// eventTimestampsS.Push(63.068);
		// eventTypes.Push(SINGLE);
		// eventShotTypes.Push(DAZZLER_BALL);
		// eventArg0Ints.Push(2);
		// eventArg0Floats.Push(JUMP_HEIGHT);

		eventTimestampsS.Push(63.068);
		eventTypes.Push(VERTICAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(2);
		eventArg0Floats.Push(EVENT_ARG_NA);

		// Double event
		// JK
		// eventTimestampsS.Push(63.187);
		// eventTypes.Push(SINGLE);
		// eventShotTypes.Push(DAZZLER_BALL);
		// eventArg0Ints.Push(3);
		// eventArg0Floats.Push(CROUCH_HEIGHT);

		// eventTimestampsS.Push(63.187);
		// eventTypes.Push(SINGLE);
		// eventShotTypes.Push(DAZZLER_BALL);
		// eventArg0Ints.Push(3);
		// eventArg0Floats.Push(JUMP_HEIGHT);

		eventTimestampsS.Push(63.187);
		eventTypes.Push(VERTICAL_LINE);
		eventShotTypes.Push(DAZZLER_BALL);
		eventArg0Ints.Push(3);
		eventArg0Floats.Push(EVENT_ARG_NA);

		eventTimestampsS.Push(64.615);
		eventTypes.Push(HUD_WIN);
		eventShotTypes.Push(SHOT_NONE);
		eventArg0Ints.Push(EVENT_ARG_NA);
		eventArg0Floats.Push(EVENT_ARG_NA);

		////// End of song - marker for end of game //////
		// eventTimestampsS.Push(eventTimestampsS[eventTimestampsS.Size() - 2] + 5.0); // Debug auto space to 5 seconds after end of song
		eventTimestampsS.Push(66.000);
		eventTypes.Push(NOOP);
		eventShotTypes.Push(SHOT_NONE);
		eventArg0Ints.Push(EVENT_ARG_NA);
		eventArg0Floats.Push(EVENT_ARG_NA);

		// #endregion Event definitions

		if (eventTimestampsS.Size() != eventTypes.Size() || eventTimestampsS.Size() != eventArg0Ints.Size()) {
				ThrowAbortException("event array sizes did not match. eventTimeStampS=%d eventTypes=%d eventArg0Ints=%d", eventTimestampsS.Size(), eventTypes.Size(), eventArg0Ints.Size());
		}
  }
}