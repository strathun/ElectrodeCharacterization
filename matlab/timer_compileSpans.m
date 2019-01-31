a = timer;
set(a,'executionMode','fixedRate')
set(a,'TimerFcn','compileSpans')
set(a,'Period',60*3);
start(a)

% timerss = timerfindall;
% delete(timerss);