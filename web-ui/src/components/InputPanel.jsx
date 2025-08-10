import { useState } from 'react';
import { useFrame } from '@react-three/fiber';

function InputPanel({ setThoughts }) {
  const [content, setContent] = useState('');
  const [emotion, setEmotion] = useState('joy');

  // Simulate "projecting" thought into space
  const handleSubmit = () => {
    if (content.trim() === '') return;

    const newThought = {
      id: Date.now(),
      content,
      emotion,
      position: [0, 0, 0],        // Start from center
      targetPosition: [
        Math.random() * 4 - 2, 
        Math.random() * 4 - 2, 
        Math.random() * 4 - 2
      ],  // Destination in space
    };

    setThoughts(prev => [...prev, newThought]);
    setContent('');
  };

  return (
    <div className="w-full md:w-64 bg-gray-900 p-4 flex flex-col gap-3">
      <input
        type="text"
        placeholder="Enter your thought..."
        value={content}
        onChange={(e) => setContent(e.target.value)}
        onKeyDown={(e) => e.key === 'Enter' && handleSubmit()}
        className="p-2 rounded bg-gray-800 text-white w-full"
      />
      
      <select 
        value={emotion} 
        onChange={(e) => setEmotion(e.target.value)} 
        className="p-2 rounded bg-gray-800 text-white w-full"
      >
        {['joy', 'anger', 'fear', 'sadness', 'excitement'].map(mood => (
          <option key={mood} value={mood}>{mood.charAt(0).toUpperCase() + mood.slice(1)}</option>
        ))}
      </select>

      <button onClick={handleSubmit} className="p-2 bg-blue-600 rounded">
        🧠 Project Thought (Enter or Click)
      </button>
    </div>
  );
}

export default InputPanel;
