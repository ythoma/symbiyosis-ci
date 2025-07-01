library ieee;
use ieee.std_logic_1164.all;

entity psl_sequence is
    port (
        clk : in std_logic
    );
end entity psl_sequence;

architecture psl of psl_sequence is

    signal start, run, end1: std_logic;

begin

    -- All is sensitive to rising edge of clk
    default clock is rising_edge(clk);

    --                                              012345678901
    seq_start : entity work.sequencer generic map ("_-__________") port map (clk, start);
    seq_run   : entity work.sequencer generic map ("____________") port map (clk, run);
    seq_end1  : entity work.sequencer generic map ("__-_________") port map (clk, end1);

    assert_success1: assert always (start -> next(run until end1));
    /*assert_fail: assert always (start -> next(run until_ end1));*/


end architecture psl;
