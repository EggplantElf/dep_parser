
gold='../data/english/test/wsj_test.conll06'
train_file='../tmp/wsj_train.fold.cx'
test_file='../tmp/wsj_test.cx'

sent_parser='../tmp/sent.fold.parser'
IOB_sent_parser='../tmp/IOB_sent.fold.parser'
chunk_parser='../tmp/chunk.fold.parser'
clause_parser='../tmp/clause.fold.parser'
chunk_sent_parser='../tmp/chunk_sent.fold.parser'
clause_sent_parser='../tmp/clause_sent.fold.parser'


baseline_output='../tmp/wsj_test.fold.baseline.conll06'
IOB_output='../tmp/wsj_test.fold.IOB.conll06'
chunk_output='../tmp/wsj_test.fold.chunk.conll06'
clause_output='../tmp/wsj_test.fold.clause.conll06'



echo run-test.sh

# baseline
python unit_parser_main.py -baseline -train $train_file $sent_parser
python unit_parser_main.py -baseline -test $test_file $sent_parser $baseline_output

# baseline + IOB
python unit_parser_main.py -IOB -train $train_file $IOB_sent_parser
python unit_parser_main.py -IOB -test $test_file $IOB_sent_parser $IOB_output

# parse chunk
python unit_parser_main.py -chunk -train $train_file $chunk_parser $chunk_sent_parser 
python unit_parser_main.py -chunk -test $test_file $chunk_parser $chunk_sent_parser ../tmp/wsj_test.chunk_output.1.3.conll06 1.3

# parse clause
python unit_parser_main.py -clause -train $train_file $clause_parser $clause_sent_parser 
python unit_parser_main.py -clause -test $test_file $clause_parser $clause_sent_parser ../tmp/wsj_test.clause_output.1.2.conll06 1.2


# results
echo baseline
perl eval07.pl -q -p -g $gold -s $baseline_output

echo IOB
perl eval07.pl -q -p -g $gold -s $IOB_output

echo ../tmp/wsj_test.chunk_output.$f.conll06
perl eval07.pl -q -p -g $gold -s ../tmp/wsj_test.chunk_output.$f.conll06  

echo ../tmp/wsj_test.clause_output.$f.conll06
perl eval07.pl -q -p -g $gold -s ../tmp/wsj_test.clause_output.$f.conll06  

