import React, { useRef, useState } from 'react';
import { useFrame, useThree } from '@react-three/fiber';
import { useDrag } from '@use-gesture/react';
import * as THREE from 'three';
import { Text, Billboard } from '@react-three/drei';

function ThoughtNode({ thought, onClick }) {
  const meshRef = useRef();
  const { size, viewport } = useThree();
  const aspect = size.width / viewport.width;

  const [position, setPosition] = useState([0, 0, 0]);
  const [targetPosition] = useState(thought.targetPosition);
  const [progress, setProgress] = useState(0);

  useFrame(() => {
    if (progress < 1) {
      setProgress(prev => prev + 0.02); // Fly toward target
      meshRef.current.position.lerp(
        new THREE.Vector3(...targetPosition),
        progress
      );
    }
  });

  const bind = useDrag(
    ({ offset: [x, y] }) => {
      const [, , z] = position;
      setPosition([x / aspect, -y / aspect, z]);
    },
    { pointerEvents: true }
  );

  return (
    <group
      ref={meshRef}
      position={position}
      onClick={onClick}
      {...bind()}
    >
      <mesh>
        <sphereGeometry args={[0.3, 32, 32]} />
        <meshStandardMaterial color={emotionToColor(thought.emotion)} />
      </mesh>
      <Billboard>
        <Text
          position={[0, -0.6, 0]}
          fontSize={0.15}
          color="white"
          anchorX="center"
          anchorY="middle"
        >
          {thought.content.slice(0, 20)}
        </Text>
      </Billboard>
    </group>
  );
}

function emotionToColor(emotion) {
  const colors = {
    joy: '#FFD700',
    anger: '#FF4500',
    fear: '#8A2BE2',
    sadness: '#1E90FF',
    excitement: '#32CD32'
  };
  return colors[emotion] || '#FFFFFF';
}

export default ThoughtNode;