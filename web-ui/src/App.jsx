import { useState } from 'react';
import ThoughtCanvas from './components/ThoughtCanvas';
import InputPanel from './components/InputPanel';

function App() {
  const [thoughts, setThoughts] = useState([]);

  return (
    <div style={{ background: 'black', fontcolor: 'white', width: '100%', height: '600px' }}>
      <InputPanel setThoughts={setThoughts} />
      <div className="absolute inset-0">
        <ThoughtCanvas thoughts={thoughts} />
      </div>
    </div>
  );
}

export default App;
