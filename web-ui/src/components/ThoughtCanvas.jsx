import { Canvas } from '@react-three/fiber';
import { OrbitControls, Text } from '@react-three/drei';
import ThoughtNode from './ThoughtNode';

function ThoughtCanvas({ thoughts }) {
  return (
    <Canvas camera={{ position: [0, 0, 5] }} style={{ background: 'black', height: '600px' }}>
      <ambientLight intensity={0.5} />
      <pointLight position={[10, 10, 10]} />

      {thoughts.map(thought => (
        <ThoughtNode 
          key={thought.id}
          thought={thought}
          onClick={() => console.log("Thought clicked:", thought)}
        />
      ))}

      <OrbitControls enableZoom={true} enablePan={true} />
    </Canvas>
  );
}

export default ThoughtCanvas;
