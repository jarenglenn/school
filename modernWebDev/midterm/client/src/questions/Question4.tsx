import { useEffect, useState } from "react";

function useTimedState<T>(initialState: T | null, timeout: number) {
  const [state, setState] = useState<T | null>(initialState);

  useEffect(() => {
    const timeoutFn = setTimeout(() => {
      setState(null);
    }, timeout);

    return () => clearTimeout(timeoutFn);
  }, [state]);

  return [state, setState] as const;
}

export const Question4 = () => {
  const [message, setMessage] = useTimedState<string>(null, 3000);

  return (
    <section className="question">
      <h2>Question 4</h2>
      <div className="question-content">
        <strong>Instructions</strong>
        <div className="question-instructions">
          A common interaction when saving something is to pop up a message that indicates
          the save was performed successfully, then, after a few seconds, the message is
          automatically removed. For this question you need to implement that interaction.
          Here are the requirements:
          <ol>
            <li>Give me a button I can push that says "Save"</li>
            <li>
              When I push the button a message should be dispaly that says "Success!"
            </li>
            <li>After 3 seconds, the message should be automatically removed.</li>
          </ol>
          <div>Be sure to follow unidirectional dataflow!</div>
          Hint: you will need a useEffect hook.
        </div>
        <hr />
        <div className="solution-section">
          <button onClick={() => setMessage("Success!")}>Save</button>
          {message && <div>{message}</div>}
        </div>
      </div>
    </section>
  );
};
