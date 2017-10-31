function b = randsrc (n, m, alphabet, seed)

  switch (nargin)
    case 0,
      m = 1;
      n = 1;
      alphabet = [-1,1];
      seed = Inf;
    case 1,
      m = n;
      alphabet = [-1,1];
      seed = Inf;
    case 2,
      alphabet = [-1,1];
      seed = Inf;
    case 3,
      seed = Inf;      
    case 4,
    otherwise
     % usage ("b = randsrc (n, [m, [alphabet, [seed]]])");
  end %switch

  %%%% Check alphabet
  [ar,ac] = size (alphabet);
  if (ac == 1)
    b = alphabet (1, 1) * ones (n, m);
    return;
  end %if

  if (ar == 1)
    prob = [1:ac] / ac;
  elseif (ar == 2)
    prob = alphabet(2,:);
    alphabet = alphabet(1,:);
    if (abs(1-sum(prob)) > eps)
    %  error ("randsrc: probabilities must added up to one");
    end%if
    prob = cumsum(prob);
  else
   % error ("randsrc: alphabet must have 1 or 2 rows");
    end %if
  
  % Check seed;
  %if (!isinf (seed))
  %  old_seed = rand ('seed');
  %  rand ('seed', seed);
  %end %if
  
  %%%% Create indexes with the right probabilities
  tmp = rand (n, m);
  b = ones (n, m);
  for i = 1:ac-1 
    b = b + (tmp > prob(i));
  end

  %%%% Map the indexes to the symbols
  b = alphabet(b);
  
  %%%%% BUG: the above gives a row vector for some reason. Force what we want
  b = reshape(b, n, m);
    
  %%%%% Get back to the old
  %if (!isinf (seed))
  %  rand ("seed", old_seed);
  %end %if

%end%function